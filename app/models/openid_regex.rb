class OpenidRegex < ActiveRecord::Base
  validates_uniqueness_of :regex
  validates_presence_of :regex, :title

  def validate
    begin
      Regexp.new(regex) unless regex.blank?
    rescue RegexpError => e
      self.add(:regex, "invalid regular expression")
    end
  end
end
