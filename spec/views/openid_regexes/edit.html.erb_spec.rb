require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/openid_regexes/edit.html.erb" do
  include OpenidRegexesHelper
  
  before(:each) do
    assigns[:openid_regex] = @openid_regex = stub_model(OpenidRegex,
      :new_record? => false,
      :regex => "value for regex",
      :title => "value for title"
    )
  end

  it "should render edit form" do
    render "/openid_regexes/edit.html.erb"
    
    response.should have_tag("form[action=#{openid_regex_path(@openid_regex)}][method=post]") do
      with_tag('input#openid_regex_regex[name=?]', "openid_regex[regex]")
      with_tag('input#openid_regex_title[name=?]', "openid_regex[title]")
    end
  end
end


