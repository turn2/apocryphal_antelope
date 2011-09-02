require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Winner do
  it { should allow_mass_assignment_of(:winner_name) }
  it { should allow_mass_assignment_of(:wholesaler_id) }
  it { should validate_presence_of(:winner_name) }
end
