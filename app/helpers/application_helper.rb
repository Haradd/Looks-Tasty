module ApplicationHelper
  def link_to_title(first_word, second_word, href)
    "<a href='#{href}'><h1>#{first_word}<em>#{second_word}</em></h1></a>".html_safe
  end

  def link_to_first_recipe(name, href, class_arg)
    "<a class='#{class_arg[:class]}' href='#{href}#first'>#{name}</a>".html_safe
  end
end
