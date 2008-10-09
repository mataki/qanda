require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AnswersController do

  def mock_answer(stubs={})
    @mock_answer ||= mock_model(Answer, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all answers as @answers" do
      Answer.should_receive(:find).with(:all).and_return([mock_answer])
      get :index
      assigns[:answers].should == [mock_answer]
    end

    describe "with mime type of xml" do
  
      it "should render all answers as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Answer.should_receive(:find).with(:all).and_return(answers = mock("Array of Answers"))
        answers.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested answer as @answer" do
      Answer.should_receive(:find).with("37").and_return(mock_answer)
      get :show, :id => "37"
      assigns[:answer].should equal(mock_answer)
    end
    
    describe "with mime type of xml" do

      it "should render the requested answer as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Answer.should_receive(:find).with("37").and_return(mock_answer)
        mock_answer.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new answer as @answer" do
      Answer.should_receive(:new).and_return(mock_answer)
      get :new
      assigns[:answer].should equal(mock_answer)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested answer as @answer" do
      Answer.should_receive(:find).with("37").and_return(mock_answer)
      get :edit, :id => "37"
      assigns[:answer].should equal(mock_answer)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created answer as @answer" do
        Answer.should_receive(:new).with({'these' => 'params'}).and_return(mock_answer(:save => true))
        post :create, :answer => {:these => 'params'}
        assigns(:answer).should equal(mock_answer)
      end

      it "should redirect to the created answer" do
        Answer.stub!(:new).and_return(mock_answer(:save => true))
        post :create, :answer => {}
        response.should redirect_to(answer_url(mock_answer))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved answer as @answer" do
        Answer.stub!(:new).with({'these' => 'params'}).and_return(mock_answer(:save => false))
        post :create, :answer => {:these => 'params'}
        assigns(:answer).should equal(mock_answer)
      end

      it "should re-render the 'new' template" do
        Answer.stub!(:new).and_return(mock_answer(:save => false))
        post :create, :answer => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested answer" do
        Answer.should_receive(:find).with("37").and_return(mock_answer)
        mock_answer.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :answer => {:these => 'params'}
      end

      it "should expose the requested answer as @answer" do
        Answer.stub!(:find).and_return(mock_answer(:update_attributes => true))
        put :update, :id => "1"
        assigns(:answer).should equal(mock_answer)
      end

      it "should redirect to the answer" do
        Answer.stub!(:find).and_return(mock_answer(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(answer_url(mock_answer))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested answer" do
        Answer.should_receive(:find).with("37").and_return(mock_answer)
        mock_answer.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :answer => {:these => 'params'}
      end

      it "should expose the answer as @answer" do
        Answer.stub!(:find).and_return(mock_answer(:update_attributes => false))
        put :update, :id => "1"
        assigns(:answer).should equal(mock_answer)
      end

      it "should re-render the 'edit' template" do
        Answer.stub!(:find).and_return(mock_answer(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested answer" do
      Answer.should_receive(:find).with("37").and_return(mock_answer)
      mock_answer.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the answers list" do
      Answer.stub!(:find).and_return(mock_answer(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(answers_url)
    end

  end

end
