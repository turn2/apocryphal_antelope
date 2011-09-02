Factory.define :plumber do |plumber|
  plumber.contact_name "Fred"
  plumber.phone "1234567890"
  plumber.street_address "123 Main"
  plumber.city "Dearborn"
  plumber.state "MI"
  plumber.postal_code "48124"
  plumber.association :wholesaler
end
