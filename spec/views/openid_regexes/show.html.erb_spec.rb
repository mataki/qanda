require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/openid_regexes/show.html.erb" do
  include OpenidRegexesHelper
  
  before(:each) do
    assigns[:openid_regex] = @openid_regex = stub_model(OpenidRegex,
      :regex => "value for regex",
      :title => "value for title"
    )
  end

  it "should render attributes in <p>" do
    render "/openid_regexes/show.html.erb"
    response.should have_text(/value\ for\ regex/)
    response.should have_text(/value\ for\ title/)
  end
end

