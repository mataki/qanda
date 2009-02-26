require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OpenidRegex do
  before(:each) do
    @valid_attributes = {
      :title => "title",
      :regex => "regex"
    }
  end

  it "should create a new instance given valid attributes" do
    OpenidRegex.create!(@valid_attributes)
  end
end

