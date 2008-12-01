require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Question do
  before(:each) do
    @valid_attributes = {
      :content => "value for content",
      :identity_url => "value for identity_url"
    }
  end

  it "should create a new instance given valid attributes" do
    Question.create!(@valid_attributes)
  end
end

describe Question, "#owner_regexs=" do
  before do
    @regexs = "http://hoge.*,https://*"
    @question = Question.new
    @question.owner_regexs = @regexs
  end
  it "questionにowner_regexsが設定されていること" do
    @question.owner_regexs.length.should == 2
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
