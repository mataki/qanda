class Question < ActiveRecord::Base
  has_many :answers
  has_many :owner_regexs, :through => :owners, :source => :openid_regex
  has_many :owners
  has_many :viewer_regexs, :through => :viewers, :source => :openid_regex
  has_many :viewers

  validates_presence_of :content
  validates_presence_of :title
  validates_presence_of :identity_url

  attr_accessor :owner_regexs_str, :viewer_regexs_str

  def before_validation
    owner_regexs.clear
    unless owner_regexs_str.blank?
      owner_regexs.build conversion_regex_str_to_rebex_hash(owner_regexs_str)
    else
      owner_regexs.build conversion_regex_str_to_rebex_hash("*")
    end
    viewer_regexs.clear
    unless viewer_regexs_str.blank?
      viewer_regexs.build conversion_regex_str_to_rebex_hash(viewer_regexs_str)
    else
      viewer_regexs.build conversion_regex_str_to_rebex_hash("*")
    end
  end

  def owner_regexs_str
    @owner_regexs_str ||= owner_regexs.map{|regex| regex.regex }.join(',')
  end

  def viewer_regexs_str
    @viewer_regexs_str ||= viewer_regexs.map{|regex| regex.regex }.join(',')
  end

  def viewer?(identity_url)
    viewer_regexs.any? do |regex|
      Regexp.new(regex.regex).match(identity_url)
    end
  end

  def owner?(identity_url)
    owner_regexs.any? do |regex|
      Regexp.new(regex.regex).match(identity_url)
    end
  end

  def accsessible?(identity_url)
    viewer? or owner?
  end

  def self.find_by_user(identity_url)
    new_questions = all(:conditions => ["created_at > ?", Time.now - 7.day])
    answered_questions = all(:conditions => { "answers.identity_url" => identity_url}, :include => :answers)

    return { :new => new_questions, :answered => answered_questions }
  end

  def grid_header
    answers.first.content.keys.sort
  end
private
  def conversion_regex_str_to_rebex_hash(regexs_str)
    regexs = regexs_str ? regexs_str.split(',').map(&:strip).uniq : []

    attrs = regexs.map do |regex|
      { :regex => regex }
    end
    attrs
  end
end
