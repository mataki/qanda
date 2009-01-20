class AnswersController < ApplicationController
  before_filter :find_question

  def index
    @answers = @question.answers

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.xml
  def show
    @answer = @question.answers.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.xml
  def new
    @answer = @question.answers.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # POST /answers
  # POST /answers.xml
  def create
    @answer = @question.answers.build(:identity_url => session[:identity_url])
    @answer.set_content(params)

    respond_to do |format|
      if @answer.save
        flash[:success] = _('Answer was successfully created.')
        format.html { redirect_to([@question, @answer]) }
        format.xml  { render :xml => @answer, :status => :created, :location => @answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

private
  def find_question
    @question = Question.find(params[:question_id])
    raise ActiveRecord::RecordNotFound unless @question.accessible_by(current_user, params[:controller], params[:action])
  end
end
