require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OpenidRegexesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "openid_regexes", :action => "index").should == "/openid_regexes"
    end
  
    it "should map #new" do
      route_for(:controller => "openid_regexes", :action => "new").should == "/openid_regexes/new"
    end
  
    it "should map #show" do
      route_for(:controller => "openid_regexes", :action => "show", :id => 1).should == "/openid_regexes/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "openid_regexes", :action => "edit", :id => 1).should == "/openid_regexes/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "openid_regexes", :action => "update", :id => 1).should == "/openid_regexes/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "openid_regexes", :action => "destroy", :id => 1).should == "/openid_regexes/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/openid_regexes").should == {:controller => "openid_regexes", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/openid_regexes/new").should == {:controller => "openid_regexes", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/openid_regexes").should == {:controller => "openid_regexes", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/openid_regexes/1").should == {:controller => "openid_regexes", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/openid_regexes/1/edit").should == {:controller => "openid_regexes", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/openid_regexes/1").should == {:controller => "openid_regexes", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/openid_regexes/1").should == {:controller => "openid_regexes", :action => "destroy", :id => "1"}
    end
  end
end
