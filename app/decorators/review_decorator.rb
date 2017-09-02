class ReviewDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def formatted_created_at
    created_at.strftime("%d/%m/%Y")
  end

  def owner_buttons
    return unless current_user.present?
    return unless current_user.id == object.user_id
    content_tag :div, class: "btn-group" do
      concat link_to "Edit", edit_recipe_review_path(review.recipe, review),
                      remote: true, class: "btn button-full"
      concat link_to "Delete", recipe_review_path(object.recipe, review),
                      method: :delete, data: { confirm: "Are you sure?" }, class: "btn button-full"
    end
  end
end
