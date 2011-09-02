require 'fastercsv'
require 'gpw'

module CSVImports

  WHOLESALER_HEADINGS_MAP = { "Dealer Name" => 'wholesaler_name',
                              "Address"     => 'street_address',
                              "City"        => 'city',
                              "State"       => 'state',
                              "Zip"         => 'postal_code',
                              "Owner"       => 'owner',
                              "Truck"       => 'truck',
                              "Email"       => 'email',
                              "Phone"       => 'phone',
                              "Cell"        => 'cell_phone',
                              "Contact"     => 'contact_name',
                              "Fax"         => 'fax',
                              "Other"       => 'other_phone',
                              "Event date"  => 'event_date',
                              "Event start" => 'event_start',
                              "Event end"   => 'event_end',
                              "AS Sales Rep" => 'as_rep_name',
                              "Rep Email"   => 'as_rep_email',
                              "Rep Phone"   => 'as_rep_phone',
                              "Rep Cell"    => 'as_rep_cell_phone',
                              "Rep Fax"     => 'as_rep_fax',
                              "Create account" =>  'create_account',
                              "Password"    => 'password' }
  WHOLESALER_HEADINGS = WHOLESALER_HEADINGS_MAP.keys

  ACCOUNT_CREATION_FLAGS = %w(Y YES T TRUE)

  PHONE_NUMBERS = %w{phone cell_phone fax other_phone as_rep_phone as_rep_cell_phone as_rep_fax}

  class WholesalerImporter

    class << self
      def import(csv)
        new(csv).import
      end     
    end
   
    attr_reader :imported, :updated, :errors
 
    def initialize(csv_file)
      @csv_file = csv_file
      @imported, @updated, @errors = 0, 0, {:data => [], :missing_headers => [], :extra_headers => []}
    end

    def import
      csv = FasterCSV.parse(@csv_file,  :headers => true,
        :header_converters => [ lambda { |header| WHOLESALER_HEADINGS_MAP[header] }],
        :converters        => [ lambda { |cell| cell.nil? ? "" : cell.strip },
                                lambda { |cell, info| info.header == 'postal_code' ? cell.rjust(5, "0") : cell },
                                lambda { |cell, info| PHONE_NUMBERS.include?(info.header) ? cleanse_number(cell) : cell }
                              ]
      )
      if headers_okay?(csv) && data_okay?(csv)
        users_created = []

        csv.each do |row|
          w = Wholesaler.find(:first, :conditions => ["UPPER(wholesaler_name) = ? and postal_code = ?", row["wholesaler_name"].upcase, row["postal_code"]]) || Wholesaler.new
          populate_wholesaler_from_row(w, row)

          if w.new_record? 
            @imported += 1
            
            # FIXME: to_s is needed because FasterCSV is converting T/True to TrueClass
            if row.header?('create_account') && ACCOUNT_CREATION_FLAGS.include?(row['create_account'].to_s.upcase)
              password = row['password'].blank? ? generate_password : row['password']
              user = w.build_user(:email => row['email'], :password => password, :password_confirmation => password)
              user.confirm_email!
              WholesalerMailer.deliver_creation(user)
              users_created << user
            end
          else 
            @updated += 1
          end

          w.save!
        end

        WholesalerMailer.deliver_creation_summary(users_created) if users_created.length > 0
      end
      self
    end
 
    def succeeded?
      (@errors.reject { |k,v| v.empty? }).empty?
    end

    def to_s
      if succeeded?
        str = "Batch uploaded successfully.  #{@imported} Wholesaler(s) added.  #{@updated} Wholesaler(s) updated."
      else
        str = "Batch upload failed."
        str += "  Wholesaler data is not formatted properly or is missing for row(s) #{@errors[:data].join(', ')}." unless @errors[:data].empty?
        str += "  Missing required column(s) #{@errors[:missing_headers].join(', ')}." unless @errors[:missing_headers].empty?
      end
      str
    end

    private 
  
    def data_okay?(csv)
      csv.each_with_index do |row, index|
        w = Wholesaler.new
        begin
          populate_wholesaler_from_row(w, row)
          @errors[:data] << (index + 1) unless w.valid?
        rescue ArgumentError # BAD DATE, INDY!
          @errors[:data] << (index + 1)
        end
      end           
      @errors[:data].empty?
    end
 
    def headers_okay?(csv)
      @errors[:missing_headers] << "Dealer Name" unless csv.headers.include?('wholesaler_name')
      @errors[:missing_headers] << "Zip" unless csv.headers.include?('postal_code')
      @errors[:missing_headers] << "Event date" unless csv.headers.include?('event_date')
      @errors[:missing_headers].empty?
    end

    def populate_wholesaler_from_row(wholesaler, row)
      row.headers.reject { |x| x.nil? or x == 'event_date' }.each do |attribute|
        wholesaler[attribute] = row[attribute] unless row[attribute].blank?
      end
      wholesaler.event_date = Date.parse(row['event_date'], comp=true) unless row['event_date'].blank?
    end

    def generate_password
      @gpw ||= Gpw.new
      @gpw.password
    end

    def cleanse_number(number)
      number.gsub!(/[^0-9]/, "")   
    end
  end
end
