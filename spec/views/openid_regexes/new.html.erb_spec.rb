require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/openid_regexes/new.html.erb" do
  include OpenidRegexesHelper
  
  before(:each) do
    assigns[:openid_regex] = stub_model(OpenidRegex,
      :new_record? => true,
      :regex => "value for regex",
      :title => "value for title"
    )
  end

  it "should render new form" do
    render "/openid_regexes/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", openid_regexes_path) do
      with_tag("input#openid_regex_regex[name=?]", "openid_regex[regex]")
      with_tag("input#openid_regex_title[name=?]", "openid_regex[title]")
    end
  end
end


