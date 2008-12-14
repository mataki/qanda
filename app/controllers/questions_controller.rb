class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.xml
  def index
    @questions = Question.find(:all)

    @answerable_questions, @answered_questions = divide_questions

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
    unless @question.answers.empty?
      flash[:error] = "Question was not edit because it has answers."
      redirect_to(@question)
    end
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question].merge(:identity_url => session[:identity_url]))

    respond_to do |format|
      if @question.save
        flash[:success] = 'Question was successfully created.'
        format.html { redirect_to(@question) }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      unless @question.answers.empty?
        flash[:error] = "Question was not edit because it has answers."
        format.html { redirect_to(@question) }
      end

      if @question.update_attributes(params[:question])
        flash[:success] = 'Question was successfully updated.'
        format.html { redirect_to(@question) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      flash[:success] = "Question was destroied."
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end

  private

  def divide_questions
    identity_url = session[:identity_url]
    answerable_questions = Array.new
    answered_questions = Array.new

    @questions.each do |question|
      if question.viewer_regexs.any?{|regex| regex.regex =~ /#{identity_url}/}
        if question.answers.any?{|answer| answer.identity_url =~ /#{identity_url}/}
          answered_questions << question
        else
          answerable_questions << question
        end
      end
    end
    return answerable_questions, answered_questions
  end
end
