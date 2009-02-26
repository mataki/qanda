class Question < ActiveRecord::Base
  has_many :answers
  has_many :owner_regexes, :through => :owners, :source => :openid_regex
  has_many :owners
  has_many :viewer_regexes, :through => :viewers, :source => :openid_regex
  has_many :viewers

  validates_presence_of :content
  validates_presence_of :title
  validates_presence_of :identity_url

  attr_accessor :owner_regexes_arr, :viewer_regexes_arr

  def before_validation
    (owner_regexes_arr||[]).each do |i|
      owner_regexes << OpenidRegex.find(i)
    end
    (viewer_regexes_arr||[]).each do |i|
      viewer_regexes << OpenidRegex.find(i)
    end
  end

  def owner_regexes_arr
    @owner_regexes_arr ||= owner_regexes.map{|regex| regex.id.to_s }
  end

  def viewer_regexes_arr
    @viewer_regexes_arr ||= viewer_regexes.map{|regex| regex.id.to_s }
  end

  def viewer?(identity_url)
    viewer_regexes.any? do |regex|
      Regexp.new(regex.regex).match(identity_url)
    end
  end

  def owner?(identity_url)
    owner_regexes.any? do |regex|
      Regexp.new(regex.regex).match(identity_url)
    end
  end

  def accsessible?(identity_url)
    viewer?(identity_url) or owner?(identity_url) or self.identity_url == identity_url
  end

  # 回答可能者
  # 質問 show
  # 回答 new, create
  # オーナー
  # 質問 edit, destroy, update

  def accessible_by(current_user, controller, action)
    if identity_url == current_user
      true
    elsif controller == "questions" and %w(edit update destroy).include?(action) or (controller == "answers" and %w(index).include?(action))
      owner?(current_user)
    elsif (controller == "questions" and action == "show") or (controller == "answers" and %w(new create show).include?(action))
      accsessible?(current_user)
    else
      false
    end
  end

  def self.find_by_user(identity_url)
    new_questions = self.all(:conditions => ["created_at > ?", Time.now - 7.day]).inject([]) do |result, q|
      result << q if q.accsessible?(identity_url)
      result
    end
    answered_questions = self.all(:conditions => { "answers.identity_url" => identity_url}, :include => :answers).inject([]) do |result, q|
      result << q if q.accsessible?(identity_url)
      result
    end

    return { :new => new_questions, :answered => answered_questions }
  end

  def grid_header
    answers.map{|answer| answer.content.keys }.flatten.uniq.sort
  end
private
  def conversion_regex_str_to_regex_hash(regexes_str)
    regexes = regexes_str ? regexes_str.split(',').map(&:strip).uniq : []

    attrs = regexes.map do |regex|
      { :regex => regex }
    end
    attrs
  end
end
