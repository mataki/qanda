require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OpenidRegex do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    OpenidRegex.create!(@valid_attributes)
  end
end

# describe OpenidRegex, "#regex" do
#   describe "同じregexが登録されている場合" do
#     before do
#       @question = Question.new(:identity_url => "http://user.example.com/", :title => "title", :content => "content")
#       @question.owner_regexs_str = "*,*"
#     end
#     it "保存に失敗すること" do
#       @question.save.should be_false
#     end
#   end
# end
