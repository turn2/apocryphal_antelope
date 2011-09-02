require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WaterSaving do
  it { should validate_presence_of(:gallons) }
  it { should validate_numericality_of(:gallons) }
end
