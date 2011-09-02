require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Part do
  it { should belong_to(:wholesaler) }

  it { should allow_mass_assignment_of(:part_name) }
  it { should allow_mass_assignment_of(:quantity) }
  it { should allow_mass_assignment_of(:total_sale_price) }
  it { should allow_mass_assignment_of(:part_number) }
  it { should allow_mass_assignment_of(:date_of_sale) }
  
  it { should validate_numericality_of(:quantity).with_message("must be a whole number greater than 0") }

  it "should require the presence of all attributes" do
    [:part_name, :quantity, :total_sale_price, :part_number, :date_of_sale].each do |attr|
      subject.valid?
      subject.errors.on(attr).should include("can't be blank")
    end
  end

  describe "total sale price" do
    it "should set total sale price in cents from money" do
      part = Factory(:part)
      part.total_sale_price = "$40.12"
      part.total_sale_price_in_cents.should == 4012
    end
  end

  describe "csv_for" do
    it "should provide nice headers" do
      Part.csv_for([]).should == "Product Name,Quantity,Total Sale Price,Part Number,Date of Sale,Wholesaler\n"
    end

    it "should put the collection into the csv" do
      p = Part.create!(:part_name => "Fridge", :quantity => 1, :total_sale_price => "949.00", 
                       :part_number => "ABC123", :date_of_sale => Date.parse("12/24/2010"))
      p.wholesaler = Factory(:wholesaler, :wholesaler_name => "Fred")
      p.save!
      Part.csv_for([p]).should == "Product Name,Quantity,Total Sale Price,Part Number,Date of Sale,Wholesaler\nFridge,1,$949.00,ABC123,2010-12-24,Fred\n"
    end
  end
end
