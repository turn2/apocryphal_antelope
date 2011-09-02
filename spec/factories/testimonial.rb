Factory.define :testimonial do |testimonial|
  testimonial.association :wholesaler
  testimonial.quote       "Quote"
  testimonial.author      "Author" 
end
