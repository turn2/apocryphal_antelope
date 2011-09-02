require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CSVImports::WholesalerImporter do
  describe "Importing wholesalers" do
    context "Adding new wholesalers" do
      before(:each) do
        @csv = "Dealer Name,Address,Zip,Event date\nFoocets,1234 Main street, 12345, 1/10/2010"
      end

      it "should create new wholesalers from a csv" do
        w = CSVImports::WholesalerImporter.import(@csv)
        Wholesaler.last.wholesaler_name.should == "Foocets"
        Wholesaler.last.event_date.should == Date.parse("1/10/2010")
      end
      
      it "should clean up phone numbers when creating new wholesalers from a csv" do
        w = CSVImports::WholesalerImporter.import("Dealer Name,Phone,Zip,Event date\nFoocets,(313)555-1919,12345,1/10/2010")
        Wholesaler.last.phone.should == '3135551919'
        Wholesaler.last.event_date.should == Date.parse("1/10/2010")
      end

      it "should keep track of the number of wholesalers that were added" do
        w = CSVImports::WholesalerImporter.import(@csv)
        w.imported.should == 1
      end
    end

    context "Updating existing wholesalers" do
      before(:each) do
        @wholesaler = Factory(:wholesaler, :wholesaler_name => "Joe's Wholesaler", :postal_code => "02345", :event_date => Date.parse("01/01/2010"), :street_address => "1234 Main street")
        @csv = "Dealer Name,Zip,Event date\nJoe's Wholesaler, 02345, 2/20/2010"
      end
 
      it "should update a wholesaler's attributes" do
        w = CSVImports::WholesalerImporter.import(@csv)
        @wholesaler.reload
        @wholesaler.event_date.should == Date.parse('02/20/2010')
      end

      it "should keep track of how many wholesalers were updated" do
        w = CSVImports::WholesalerImporter.import(@csv)
        w.updated.should == 1
      end

      it "should find matches on wholesaler name regardless of case" do
        @csv = "Dealer Name,Zip,Owner,Event date\njoe's wholesaler, 02345, Jim G,12/24/2010"
        w = CSVImports::WholesalerImporter.import(@csv)
        w.updated.should == 1
      end
      
      it "should find matches on wholesaler postal_code without missing leading zeroes, because Excel loves to do this when converting to CSV" do
        @csv = "Dealer Name,Zip,Email,Event date\nJoe's Wholesaler, 2345,name@example.com,12/24/2010"
        w = CSVImports::WholesalerImporter.import(@csv)
        w.updated.should == 1
      end

      it "should not overwrite existing attributes on a wholesaler with blank values from the CSV" do
        @csv = "Dealer Name,Address,Zip,Event date\nJoe's Wholesaler,,02345,1/10/2010"
        w = CSVImports::WholesalerImporter.import(@csv)
        @wholesaler.reload
        @wholesaler.street_address.should == "1234 Main street"
        @wholesaler.event_date.should == Date.parse('01/10/2010')
      end
    end
 
    context "Headings on CSV don't match required fields" do
      before(:each) do
        @csv = "Store Name,City,Zip,Proprietor,\njoe's wholesaler,Dearborn, 12345, Jim G"
      end

      it "should should not succeed" do
        w = CSVImports::WholesalerImporter.import(@csv)
        w.succeeded?.should be_false
      end

      it "should indicate the missing headers" do
        w = CSVImports::WholesalerImporter.import(@csv)
        w.to_s.should include("Missing required column(s) Dealer Name, Event date")
      end
        
    end

    context "Wholesaler for update or insertion is invalid" do
      before(:each) do
        @csv = "Dealer Name,Zip,Owner,Phone,Event date\nJoe's Wholesaler,12345, Jim G,3135551234, 1/10/2010\nIncomplete Wholesaler,,,31355512345,"
      end
 
      it "should report on bad rows" do
        w = CSVImports::WholesalerImporter.import(@csv)
        w.errors[:data].should == [2]
      end
 
      it "should not save any records when a bad record is found" do
        w = CSVImports::WholesalerImporter.import(@csv)
        Wholesaler.count.should == 0
      end

      it "should handle unparseable dates by failing with a bad row" do
        @csv = "Dealer Name,Zip,Event date\nJoe's Wholesaler,12345,Tomorrow Morning"
        w = CSVImports::WholesalerImporter.import(@csv)
        w.succeeded?.should be_false
        w.errors[:data].should == [1]
      end
    end
  end
end
