
require 'machinist/active_record'
require 'sham'
require 'faker'
require 'core_extendors'
include Faker 

Sham.define do
  person_full_name          { Faker::Name.name }
  first_name                { Faker::Name.first_name }
  last_name                 { Faker::Name.last_name }
  company_name(:unique => false)      { Faker::Company.name }
  user_name                 { "#{("a".."z").to_a.rand}#{Faker::Name.last_name.downcase}" }
  address1                  { Faker::Address.street_address }
  address2                  { Faker::Address.secondary_address }
  city                      { Faker::Address.city }
  state(:unique => false)   { "CA" }
  zip                       { Faker::Address.zip_code }
  zip_code                  { (1..5).map{ rand(10) }.join }
  phone                     { Faker::PhoneNumber.phone_number }
  clean_phone               { (1..10).map{ rand(10) }.join }
  extension                 { (1..4).map{('0'..'9').to_a.rand}.join }
  email                     { Faker::Internet.email }
  sentence                  { Faker::Lorem.sentence }
  sentences                 { Faker::Lorem.sentences.join }
  boolean(:unique => false) { [true, false].rand }
  employee_number           { String.random(10) }
  short_item_name           { Faker::Lorem.words((2..4).to_a.rand).join(" ").titleize }
  vendor_number             { String.random(12) }
  event_date                { (rand(10) + 1).months.from_now }
  due_date                  { (rand(10) + 1).months.from_now }
  truck_number(:unique => false)  { rand(2) + 1 }
  visitor(:unique => false)  { ["Wholesaler", "Retailer", "Plumber", "Consumer/End User"][rand(4)] }
end

Wholesaler.blueprint do
  wholesaler_name  { Sham.company_name     }   
  contact_name     { Sham.person_full_name }
  email            { Sham.email            }
  phone            { Sham.clean_phone      }
  street_address   { Sham.address1         }
  city             { Sham.city             }
  state            { Sham.state            }
  postal_code      { Sham.zip_code         }
  event_date       { Sham.event_date       }
  truck            { Sham.truck_number     }
  owner            { Sham.person_full_name }
  cell_phone       { Sham.clean_phone      }
  fax              { Sham.clean_phone      }
  other_phone      { Sham.clean_phone      }
  region           { Region.all.rand       }
end

TaskTemplate.blueprint do
  title        { Faker::Lorem.words((4..8).to_a.rand).join(" ").titleize }
  description  { Sham.sentences                                          }
  due_week     { rand(10) + 1 }
end

Faq.blueprint do
  question     { Sham.sentence }
  answer       { Sham.sentences }
  visible      { Sham.boolean }
  position     { Sham.slug{ |n| "#{n}"} } 
end

MediaOutlet.blueprint do
  media_outlet_name { Sham.company_name }
  region            { Region.all.rand }
  contact_name      { Sham.person_full_name }
  phone             { Sham.clean_phone }
  street_address    { Sham.address1 }
  city              { Sham.city }
  state             { Sham.state }
  postal_code       { Sham.zip_code }
  close_date        { Sham.event_date }
  release_date      { Sham.event_date }
  comments          { Sham.sentences }
  email             { Sham.email }
  cell_phone        { Sham.clean_phone }
  fax               { Sham.clean_phone }
  other_phone       { Sham.clean_phone }
  media_type        { Faker::Lorem.words(1).join }
  url               { "http://www.fakeurl.com" }
end

Region.blueprint do
  region_name { Sham.short_item_name }
end

Plumber.blueprint do
  contact_name      { Sham.person_full_name }
  email             { Sham.email }
  phone             { Sham.clean_phone }
  street_address    { Sham.address1 }
  city              { Sham.city }
  state             { Sham.state }
  postal_code       { Sham.zip_code }
  company_name      { Sham.company_name }
  cell_phone        { Sham.clean_phone }
  fax               { Sham.clean_phone }
  other_phone       { Sham.clean_phone }
  wholesaler        { Wholesaler.all.rand }
end

Followup.blueprint do
  description  { Sham.sentence }
  complete     { Sham.boolean }
  due_date     { Sham.due_date }
  task         { Task.all.rand }
  media_outlet { MediaOutlet.all.rand }
end

Prospect.blueprint do
  name                       { Sham.person_full_name }
  email                      { Sham.email }
  opted_in                   { Sham.boolean }
  visitor_type               { Sham.visitor }
end

Testimonial.blueprint do
  quote       { Sham.sentences }
  author      { Sham.person_full_name }
  wholesaler  { Wholesaler.all.rand }
end

