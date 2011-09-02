require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sweepstakes do
  it "should give two find_entries to a wholesaler who's completed their certification sheet" do
    w = Factory(:wholesaler, :completed_certification_sheet => true)
    Sweepstakes.find_entries.should == [w, w]
  end

  it "should give a wholesaler an entry for each approved part they have uploaded" do
    w = Factory(:wholesaler)
    3.times do
      p = Factory(:part, :wholesaler => w)
    end
    Sweepstakes.find_entries.should == [w, w, w]
  end

  it "should limit the number of find_entries for approved parts to 50" do
    w = Factory(:wholesaler)
    51.times do
      p = Factory(:part, :wholesaler => w)
    end
    Sweepstakes.find_entries.should == [w] * 50
  end

  it "should combine part and certification sheet counts" do
    w = Factory(:wholesaler, :completed_certification_sheet => true)
    55.times do
      p = Factory(:part, :wholesaler => w)
    end
    Sweepstakes.find_entries.should == [w] * 52
  end

  it "should include all wholesalers who are participating" do
    w = Factory(:wholesaler, :completed_certification_sheet => true)
    w2 = Factory(:wholesaler, :completed_certification_sheet => true)
    Sweepstakes.find_entries.should == [w, w, w2, w2]
  end

  describe "Winners" do
    it "should select a unique random list of 14 winners and 6 alternates (20)" do
      pending
    end

    it "should limit the results to 20 total" do
      21.times do
        w = Factory(:wholesaler, :completed_certification_sheet => true)
      end
      Sweepstakes.winners.size.should == 20
    end

    it "should only return unique winners" do
      w = Factory(:wholesaler)
      3.times do
        p = Factory(:part, :wholesaler => w)
      end
      Sweepstakes.winners.should == [w]
    end
  end
end
