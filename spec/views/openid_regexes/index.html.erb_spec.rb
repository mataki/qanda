require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/openid_regexes/index.html.erb" do
  include OpenidRegexesHelper
  
  before(:each) do
    assigns[:openid_regexes] = [
      stub_model(OpenidRegex,
        :regex => "value for regex",
        :title => "value for title"
      ),
      stub_model(OpenidRegex,
        :regex => "value for regex",
        :title => "value for title"
      )
    ]
  end

  it "should render list of openid_regexes" do
    render "/openid_regexes/index.html.erb"
    response.should have_tag("tr>td", "value for regex", 2)
    response.should have_tag("tr>td", "value for title", 2)
  end
end

