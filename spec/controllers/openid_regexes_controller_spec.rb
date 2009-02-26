require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OpenidRegexesController do
  before do
    session[:identity_url] = "http://test.openid.com/id"
  end

  def mock_openid_regex(stubs={})
    @mock_openid_regex ||= mock_model(OpenidRegex, stubs)
  end

  describe "responding to GET index" do

    it "should expose all openid_regexes as @openid_regexes" do
      OpenidRegex.should_receive(:find).with(:all).and_return([mock_openid_regex])
      get :index
      assigns[:openid_regexes].should == [mock_openid_regex]
    end

    describe "with mime type of xml" do

      it "should render all openid_regexes as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        OpenidRegex.should_receive(:find).with(:all).and_return(openid_regexes = mock("Array of OpenidRegexes"))
        openid_regexes.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end

    end

  end

  describe "responding to GET show" do

    it "should expose the requested openid_regex as @openid_regex" do
      OpenidRegex.should_receive(:find).with("37").and_return(mock_openid_regex)
      get :show, :id => "37"
      assigns[:openid_regex].should equal(mock_openid_regex)
    end

    describe "with mime type of xml" do

      it "should render the requested openid_regex as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        OpenidRegex.should_receive(:find).with("37").and_return(mock_openid_regex)
        mock_openid_regex.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end

  end

  describe "responding to GET new" do

    it "should expose a new openid_regex as @openid_regex" do
      OpenidRegex.should_receive(:new).and_return(mock_openid_regex)
      get :new
      assigns[:openid_regex].should equal(mock_openid_regex)
    end

  end

  describe "responding to GET edit" do

    it "should expose the requested openid_regex as @openid_regex" do
      OpenidRegex.should_receive(:find).with("37").and_return(mock_openid_regex)
      get :edit, :id => "37"
      assigns[:openid_regex].should equal(mock_openid_regex)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do

      it "should expose a newly created openid_regex as @openid_regex" do
        OpenidRegex.should_receive(:new).with({'these' => 'params'}).and_return(mock_openid_regex(:save => true))
        post :create, :openid_regex => {:these => 'params'}
        assigns(:openid_regex).should equal(mock_openid_regex)
      end

      it "should redirect to the created openid_regex" do
        OpenidRegex.stub!(:new).and_return(mock_openid_regex(:save => true))
        post :create, :openid_regex => {}
        response.should redirect_to(openid_regex_url(mock_openid_regex))
      end

    end

    describe "with invalid params" do

      it "should expose a newly created but unsaved openid_regex as @openid_regex" do
        OpenidRegex.stub!(:new).with({'these' => 'params'}).and_return(mock_openid_regex(:save => false))
        post :create, :openid_regex => {:these => 'params'}
        assigns(:openid_regex).should equal(mock_openid_regex)
      end

      it "should re-render the 'new' template" do
        OpenidRegex.stub!(:new).and_return(mock_openid_regex(:save => false))
        post :create, :openid_regex => {}
        response.should render_template('new')
      end

    end

  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested openid_regex" do
        OpenidRegex.should_receive(:find).with("37").and_return(mock_openid_regex)
        mock_openid_regex.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :openid_regex => {:these => 'params'}
      end

      it "should expose the requested openid_regex as @openid_regex" do
        OpenidRegex.stub!(:find).and_return(mock_openid_regex(:update_attributes => true))
        put :update, :id => "1"
        assigns(:openid_regex).should equal(mock_openid_regex)
      end

      it "should redirect to the openid_regex" do
        OpenidRegex.stub!(:find).and_return(mock_openid_regex(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(openid_regex_url(mock_openid_regex))
      end

    end

    describe "with invalid params" do

      it "should update the requested openid_regex" do
        OpenidRegex.should_receive(:find).with("37").and_return(mock_openid_regex)
        mock_openid_regex.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :openid_regex => {:these => 'params'}
      end

      it "should expose the openid_regex as @openid_regex" do
        OpenidRegex.stub!(:find).and_return(mock_openid_regex(:update_attributes => false))
        put :update, :id => "1"
        assigns(:openid_regex).should equal(mock_openid_regex)
      end

      it "should re-render the 'edit' template" do
        OpenidRegex.stub!(:find).and_return(mock_openid_regex(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested openid_regex" do
      OpenidRegex.should_receive(:find).with("37").and_return(mock_openid_regex)
      mock_openid_regex.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "should redirect to the openid_regexes list" do
      OpenidRegex.stub!(:find).and_return(mock_openid_regex(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(openid_regexes_url)
    end

  end

end
