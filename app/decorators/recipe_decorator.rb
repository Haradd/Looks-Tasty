class RecipeDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def formatted_created_at
    created_at.strftime("%d/%m/%Y")
  end

  def preparation_time
    "#{time.hour}:#{time.min}"
  end

  def average_review
    reviews.average(:rating).to_f.round(2) if reviews.present?
  end

  def counts_review
    "(#{reviews.count})".strip if reviews.present?
  end

  def edit_link
    h.link_to('Edit', h.edit_recipe_path(object)).html_safe if user == h.current_user
  end

  def paginate
    h.paginate(object)
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
