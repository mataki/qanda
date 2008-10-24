class Question < ActiveRecord::Base
  has_many :answers
  has_many :owner_regexs, :through => :owners, :source => :openid_regex
  has_many :owners

  def owner_regexs=(regexs_str)
    regexs = regexs_str ? regexs_str.split(',') : []

    attrs = regexs.map do |regex|
      { :regex => regex }
    end
    owner_regexs.build attrs
  end
end
