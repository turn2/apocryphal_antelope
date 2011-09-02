class Wholesaler < ActiveRecord::Base
  include LocationAttributes
  include ContactAttributes

  attr_accessible :wholesaler_name, :event_date, :truck, :owner, :region_id, :completed_certification_sheet, 
                  :as_rep_name, :as_rep_email, :as_rep_phone, :as_rep_cell_phone, :as_rep_fax,
                  :event_start, :event_end

  # validations
  validates_presence_of :wholesaler_name, :postal_code, :event_date

  validates_format_of :as_rep_email, :with => /(\S+)@(\S+)/, :allow_blank => true
  validates_numericality_of :as_rep_phone, :as_rep_cell_phone, :as_rep_fax, :allow_blank => true, :only_integer => true
  validates_length_of :as_rep_phone, :as_rep_cell_phone, :as_rep_fax, :is => 10, :allow_blank => true

  # scope
  default_scope :order => "event_date ASC"
  
  # associations
  has_many :tasks
  has_many :testimonials, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_many :plumbers
  belongs_to :region
  has_many :media_outlets, :through => :region
  has_many :parts
  has_one :user

  # named scopes
  named_scope :event_upcoming, lambda {{ :conditions => ["event_date > ?", Date.yesterday] }}
  named_scope :event_passed, lambda {{ :conditions => ["event_date < ?", Date.today] }}
  named_scope :with_event, :conditions => ["event_date NOT NULL and event_date != ''"]
  named_scope :by_name, :order => "wholesaler_name ASC"

  class << self
    def unassigned
      Wholesaler.all.select { |w| w.region.nil? }
    end

    def create_tasks_from_task_template(task_template)
      event_upcoming.each do |wholesaler| 
        wholesaler.build_new_task(task_template)
      end
    end
     
    def csv_for(wholesalers)
      FasterCSV.generate do |csv|
        csv << [ "Wholesaler Name", "Contact Name", "Email", "Phone", "Address", "City", "State", "Zip", "Cell", "Fax", 
                 "Other Phone"]
        wholesalers.each do |wholesaler|
          csv << [ wholesaler.wholesaler_name, wholesaler.contact_name, wholesaler.email, wholesaler.phone, wholesaler.street_address,
                   wholesaler.city, wholesaler.state, wholesaler.postal_code, wholesaler.cell_phone, wholesaler.fax, wholesaler.other_phone]
        end
      end
    end

    def csv
      csv_for(all)
    end
  end
  
  def create_tasks_from_task_templates
    TaskTemplate.all.each { |tmpl| build_new_task(tmpl) }
  end

  def outstanding_tasks
    tasks.incomplete.size
  end
  
  def build_new_task(task_template)
    t = tasks.new(:due_date => due_weeks_prior_to_event(task_template.due_week)) do |task|
      task.title = task_template.title
      task.description = task_template.description
    end
    
    t.task_template = task_template
    t.save!
  end

  def reset_task_due_dates!
    tasks.map { |task| task.reset_due_date! }
  end

  def build_photos(filelist)
    count = 0
    filelist.each do |file|
      p = Photo.new
      p.picture = file
      if p.valid? # Invalid?  Throw it out.
        p.wholesaler = self
        p.save!
        count += 1
      end
    end
    count
  end
 
  def address_complete?
    address_array.each {|a| return false if a.blank? || a.nil?}
    true
  end
  alias_method :complete_address?, :address_complete?

  def google_map_url
    "http://maps.google.com?q=#{google_map_params}"
  end
  
  def google_map_params
    address_array.collect{|i| i.gsub(/\W/," ")}.join(" ").strip.gsub(/\s+/,"+")
  end

  def incomplete_tasks_per_week
    @tasks_per_week ||= tasks.incomplete.all(:include => :task_template).group_by { |t| t.due_week }
  end

  def number_of_incomplete_tasks_per_week
    incomplete_tasks_per_week.inject({}) { |h, (k,v)| h[k] = v.size; h }
  end

  [:as_rep_phone, :as_rep_cell_phone, :as_rep_fax].each do |p|
    define_method(p.to_s + "=") do |number|
      self[p] = strip_phone(number)
    end
  end

  protected
  
  def after_create
    create_tasks_from_task_templates
  end
  
  private
  
  def address_array
    [ street_address, city, state, postal_code ]
  end
  
  def due_weeks_prior_to_event(week)
    event_date - week.weeks
  end
end
