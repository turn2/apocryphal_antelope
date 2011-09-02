require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it { should have_many(:plumbers) }
  it { should belong_to(:wholesaler) }
  it { should allow_mass_assignment_of(:role) }

  it "should allow valid roles" do
    user = Factory(:user)

    User::ROLES.each do |role|
      user.role = role
      user.should be_valid
    end
  end

  it "should not allow invalid roles" do
    user = Factory(:user)
    user.role = "foobar"
    user.should_not be_valid
  end

  it "should say whether it has a role" do
    user = Factory(:user, :role => "wholesaler")
    user.has_role?("wholesaler").should be_true
    user.has_role?("manager").should be_false
  end
end
