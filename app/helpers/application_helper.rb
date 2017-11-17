module ApplicationHelper
  def link_to_title(first_word, second_word, href)
    "<a href='#{href}'><h1>#{first_word}<em>#{second_word}</em></h1></a>".html_safe
  end

  def active_link_to(name, href, class_arg)
    if current_page?(recipes_path(category: name))
      class_arg[:class] += " active"
    elsif params[:category].nil? && name == "All"
      class_arg[:class] += " active"
    end

    "<a class='#{class_arg[:class]}' href='#{href}#first'>#{name}</a>".html_safe
  end

  def sort_option
    option_name = params.permit(:sort)[:sort]
    option_name.present? ? option_name : "Sort by"
  end

  def permitted_params
    params.permit(:search, :category, :sort).to_h
  end
end
