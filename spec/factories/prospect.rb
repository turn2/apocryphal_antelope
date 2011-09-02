Factory.sequence :email do |n|
  "#{n}@example.com"
end

Factory.define :prospect do |prospect|
  prospect.name "Interested Party"
  prospect.email { Factory.next :email }
  prospect.visitor_type "Wholesaler"
end
