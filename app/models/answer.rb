class Answer < ActiveRecord::Base
  belongs_to :question

  def set_content(params)
    params.delete_if do |key, value|
      ["commit","authenticity_token", "action", "controller", "question_id"].include?(key)
    end
    #super(params)
    self.content = params.to_json
  end
end
