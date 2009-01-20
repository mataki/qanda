require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AnswersController do
  def mock_answer(stubs={})
    @mock_answer ||= mock_model(Answer, stubs)
  end

  def mock_question(stubs={})
    @mock_question ||= mock_model(Question, stubs.merge(:accessible_by => true))
  end

  before do
    session[:identity_url] = "http://test.openid.com/id"
    Question.should_receive(:find).and_return(mock_question)
  end
  describe "responding to GET index" do
    it "should expose all answers as @answers" do
      mock_question.should_receive(:answers).and_return([mock_answer])
      get :index, :question_id => 37
      assigns[:answers].should == [mock_answer]
    end
  end

  describe "responding to GET show" do
    it "should expose the requested answer as @answer" do
      mock_question.should_receive(:answers).and_return(mock_answers = mock('answers'))
      mock_answers.should_receive(:find).with("37").and_return(mock_answer)
      get :show, :question_id => "37", :id => "37"
      assigns[:answer].should equal(mock_answer)
    end
  end

  describe "responding to GET new" do
    it "should expose a new answer as @answer" do
      mock_question.should_receive(:answers).and_return(mock_answers = mock('answers'))
      mock_answers.should_receive(:build).and_return(mock_answer)
      get :new
      assigns[:answer].should equal(mock_answer)
    end
  end

  describe "responding to POST create" do
    describe "with valid params" do
      before do
        mock_answer(:save => true)
        mock_answer.should_receive(:set_content)
        mock_question.should_receive(:answers).and_return(mock_answers = mock('answers'))
        mock_answers.should_receive(:build).with(:identity_url => session[:identity_url]).and_return(mock_answer)

        post :create, :question_id => 1, :hoge => "hoge"
      end
      it "Answerにset_contentでcontentが設定されること" do
        assigns(:answer).should equal(mock_answer)
      end

      it "should redirect to the created answer" do
        response.should be_redirect
      end
    end

    describe "with invalid params" do
      before do
        mock_answer(:save => false)
        mock_answer.should_receive(:set_content)
        mock_question.should_receive(:answers).and_return(mock_answers = mock('answers'))
        mock_answers.should_receive(:build).with(:identity_url => session[:identity_url]).and_return(mock_answer)

        post :create, :question_id => 1, :hoge => "hoge"
      end
      it "should expose a newly created but unsaved answer as @answer" do
        assigns(:answer).should equal(mock_answer)
      end

      it "should re-render the 'new' template" do
        response.should render_template('new')
      end
    end
  end
end
