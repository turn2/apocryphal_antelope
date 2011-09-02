Factory.define :part do |part|
  part.part_name "Media Outlet Name"
  part.quantity 3
  part.total_sale_price_in_cents 40001
  part.part_number "FC123"
  part.date_of_sale Date.yesterday
end
