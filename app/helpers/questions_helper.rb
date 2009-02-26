module QuestionsHelper
  def navi_list(question, user)
    case
    when question.owner?(user)
      [
       link_to(_('Show'), question),
       link_to(_('Anser'), new_question_answer_path(question)),
       link_to(_('Edit'), edit_question_path(question)),
       link_to(_('Anser list'), question_answers_path(question)),
       link_to(_('Destroy'), question, :confirm => _('Are you sure?'), :method => :delete)
      ]
    when question.viewer?(user)
      [
       link_to(_('Show'), question),
       link_to(_('Anser'), new_question_answer_path(question))
      ]
    else
      []
    end
  end

  def navi_table(question, user)
    navi_list(question, user).map do |link|
      "<td>#{link}</td>"
    end.join('')
  end

  def navi_text(question, user)
    navi_list(question, user).map do |link|
      link
    end.join(' | ')
  end
end
