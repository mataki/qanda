require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Answer do
  before(:each) do
    @valid_attributes = {
      :content => "value for content",
      :identity_url => "value for identity_url"
    }
  end

  it "should create a new instance given valid attributes" do
    Answer.create!(@valid_attributes)
  end
end

describe Answer, "#set_content" do
  before do
    @answer = Answer.new
  end
  describe "paramsに消すべき要素が入っている場合" do
    before do
      @params = { "commit" => "Commit" }
    end
    it "contentに消すべき要素は含まれないこと" do
      @answer.set_content(@params)
      @answer.content.should_not be_include(@params.keys.first)
    end
  end
  describe "paramsに消すべきでない要素が入っている場合" do
    before do
      @params = { "hoge" => "hoge" }
    end
    it "contentに要素が含まれること" do
      @answer.set_content(@params)
      @answer.content.should be_include(@params.keys.first)
    end
  end
end

describe Answer, "#grid_data" do
  before do
    @answer = Answer.new(:content => { "hoge" => "foo", "fuga" => "bar" })
  end
  it "content内のkeyから値を取り出すこと" do
    @answer.grid_data("hoge").should == "foo"
  end
  it "値が見つからない場合 空文字が返ること" do
    @answer.grid_data("foo").should == ""
  end
end
