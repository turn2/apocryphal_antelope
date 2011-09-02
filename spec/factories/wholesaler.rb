Factory.sequence :wholesaler_name do |n|
  "My Wholesaler_#{n}"
end

Factory.define :wholesaler do |ws|
  ws.wholesaler_name { Factory.next :wholesaler_name }
  ws.contact_name "Joe Smith"
  ws.email "name@example.com"
  ws.phone "3135551234"
  ws.street_address "123 Main Street"
  ws.city "Nowheresville"
  ws.state "MI"
  ws.postal_code "12345"
  ws.event_date Date.tomorrow
  ws.truck 1
end

Factory.define :wholesaler_whose_event_is_over, :parent => :wholesaler do |ws|
  ws.event_date Date.yesterday
end
