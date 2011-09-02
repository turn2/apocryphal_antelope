require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "FaqAnswerHelper" do
  include FaqAnswerHelper
  it "should transform bare urls to external links" do
    text = "Hi this is a link to http://www.gooogle.com"
    format_answer(text).should == "Hi this is a link to <a href='http://www.gooogle.com' class='external'>http://www.gooogle.com</a>"
  end

  it "should replace newlines with BRs" do
    text = "Hello\nThere.  I am split"
    format_answer(text).should == "Hello<br/>There.  I am split"
  end
end
