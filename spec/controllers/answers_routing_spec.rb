require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AnswersController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "answers", :action => "index").should == "/answers"
    end
  
    it "should map #new" do
      route_for(:controller => "answers", :action => "new").should == "/answers/new"
    end
  
    it "should map #show" do
      route_for(:controller => "answers", :action => "show", :id => 1).should == "/answers/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "answers", :action => "edit", :id => 1).should == "/answers/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "answers", :action => "update", :id => 1).should == "/answers/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "answers", :action => "destroy", :id => 1).should == "/answers/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/answers").should == {:controller => "answers", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/answers/new").should == {:controller => "answers", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/answers").should == {:controller => "answers", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/answers/1").should == {:controller => "answers", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/answers/1/edit").should == {:controller => "answers", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/answers/1").should == {:controller => "answers", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/answers/1").should == {:controller => "answers", :action => "destroy", :id => "1"}
    end
  end
end
