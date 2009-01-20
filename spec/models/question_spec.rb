require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Question do
  it "should create a new instance given valid attributes" do
    Question.create!(question_valid_attributes)
  end
end

describe Question, "#before_validation" do
  before do
    @question = Question.new(:identity_url => "http://user.example.com/", :title => "title", :content => "content")
  end
  describe "データが無い場合 strが渡されていない場合" do
    it "*が追加されていること" do
      @question.save!
      @question.owner_regexs_str = nil
      @question.owner_regexs_str.should == "*"
    end
  end
  describe "同じ正規表現の場合" do
    it " 同じOpenidRegexが関連づけられていること" do
      pending "実際はこうしたいが、トランザクション内で行なわれるため非常に難しい"
#       @question.save!
#       @question.owner_regexs_str = nil
#       @question.viewer_regexs_str = nil
#       @question.owner_regexs.first.should == @question.viewer_regexs.first
    end
  end
  describe "データが存在している場合 strが渡されていない場合" do
    before do
      @question.owner_regexs_str = "http://hoge.openid.host/,http://fuga.openid.host/"
      @question.save!

      @question.owner_regexs_str = nil
      @question.save!
    end
    it "*のみが設定されていること" do
      @question.owner_regexs_str = nil
      @question.owner_regexs_str.should == "*"
    end
  end
end

describe Question, "#viewer?" do
  describe "viewの正規表現に引っかかる場合" do
    before do
      @regexs = (1..2).map{|i| stub_model(OpenidRegex, :regex => "http://hoge#{i}.com/.*")}
      @identity_url = "http://fuga.com/id"
      @question = stub_model(Question, :viewer_regexs => @regexs)
    end
    it "falseを返す" do
      @question.viewer?(@identity_url).should be_false
    end
  end
  describe "viewの正規表現に引っかからない場合" do
    before do
      @regexs = (1..2).map{|i| stub_model(OpenidRegex, :regex => "http://hoge#{i}.com/.*")}
      @identity_url = "http://hoge1.com/111111"
      @question = stub_model(Question, :viewer_regexs => @regexs)
    end
    it "trueを返す" do
      @question.viewer?(@identity_url).should be_true
    end
  end
end

describe Question, ".find_by_user" do
  before do
    @user_identity_url = "http://example.com/user/access"
    @questions = (1..5).map{ |i| Question.create!(:content => "content#{i}", :title => "title#{i}", :identity_url => "http://example.com/user/a_user#{i}") }
    @old_question = Question.create!(:content => "content", :title => "title", :identity_url => "http://example.com/user/a_user", :created_at => Time.now - 10.day)
    @ansered_question = @questions.last
    Answer.create!(:identity_url => @user_identity_url, :content => "answer", :question => @ansered_question)

    @result = Question.find_by_user(@user_identity_url)
  end
  it "newに新しい質問が含まれていること" do
    @result[:new].should == @questions
  end
  it "答えた質問に答えた質問が入っていること" do
    @result[:answered].should be_include(@ansered_question)
  end
end

describe Question, "#grid_header" do
  describe "答えが一つ登録されている場合" do
    before do
      @params = { "hoge" => "foo", "fuga" => "bar" }
      @answer = mock_model(Answer, :content => @params)
      @question = Question.new
      @question.stub!(:answers).and_return([@answer])
    end
    it "要素のkeyが返されること" do
      @question.grid_header.should == ["hoge", "fuga"].sort
    end
  end
  describe "複数の答えが登録されていて、それぞれに登録されている要素が違う場合" do
    before do
      @params1 = { "hoge" => "foo", "fuga" => "bar" }
      @answer1 = mock_model(Answer, :content => @params1)
      @params2 = { "foo" => "foo", "fuga" => "bar" }
      @answer2 = mock_model(Answer, :content => @params2)
      @question = Question.new
      @question.stub!(:answers).and_return([@answer1, @answer2])
    end
    it "すべての要素のkeyが返されること" do
      valid_keys = (@params1.keys + @params2.keys).flatten.uniq.sort
      @question.grid_header.should == valid_keys
    end
  end
end

def question_valid_attributes
  @valid_attributes = {
    :title => "value for title",
    :content => "value for content",
    :identity_url => "value for identity_url"
  }
end
