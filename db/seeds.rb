# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

require File.expand_path(RAILS_ROOT + "/spec" + "/blueprints")
require 'machinist/active_record'
require 'sham'
require 'faker'
require 'core_extendors'
include Faker 


Sham.reset

Region.destroy_all
25.times { Region.make }

Wholesaler.destroy_all
120.times { Wholesaler.make }

TaskTemplate.destroy_all
12.times { TaskTemplate.make }

Faq.destroy_all
15.times { Faq.make }

MediaOutlet.destroy_all
40.times { MediaOutlet.make }

Plumber.destroy_all
50.times { Plumber.make }

Followup.destroy_all
80.times { Followup.make }

Prospect.destroy_all
30.times { Prospect.make }

Testimonial.destroy_all
20.times { Testimonial.make } 

WaterSaving.destroy_all
WaterSaving.create( { :gallons => 12345679 } )

User.destroy_all
users = User.create([
  { :email => "mgr@blurby.com", :password => "letmein", :role => "manager" },
  { :email => "ralph@vfi.com", :password => "letmein", :role => "manager" },
  { :email => "tamara@vfi.com", :password => "letmein", :role => "manager" },
  { :email => "derek@vfi.com", :password => "letmein", :role => "manager" },
  { :email => "mike@vfi.com", :password => "letmein", :role => "manager" },
  { :email => "ralph_wholesaler@vfi.com", :password => "letmein", :role => "wholesaler" },
  { :email => "tamara_wholesaler@vfi.com", :password => "letmein", :role => "wholesaler" },
  { :email => "derek_wholesaler@vfi.com", :password => "letmein", :role => "wholesaler" },
  { :email => "mike_wholesaler@vfi.com", :password => "letmein", :role => "wholesaler" },
  { :email => "slr@blurby.com", :password => "letmein", :role => "wholesaler" }
])

# Generate a new wholesaler and attach it to the wholesaler user for testing purposes
%w[ ralph tamara derek mike ].each do |name|
  u = User.find_by_email("#{name}_wholesaler@vfi.com")
  u.wholesaler = Wholesaler.make
  u.save
end

u = User.find_by_email("slr@blurby.com")
u.wholesaler = Wholesaler.make
u.save

users.each(&:confirm_email!)
