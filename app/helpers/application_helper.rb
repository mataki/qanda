# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def render_question_content(content)
    allowed_tags = HTML::WhiteListSanitizer.allowed_tags.dup << "table" << "tbody" << "tr" << "th" << "td" << "caption" << "select" << "option" << "textarea" << "input"
    allowed_attributes = HTML::WhiteListSanitizer.allowed_attributes.dup << "style" << "cellspacing" << "cellpadding" << "border" << "align" << "summary" << "type" << "value"
    sanitize(content, :tags => allowed_tags, :attributes => allowed_attributes)
  end
end
