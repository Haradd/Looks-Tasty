class ReviewDecorator < Draper::Decorator
  delegate_all

  def formatted_created_at
    created_at.strftime("%d/%m/%Y")
  end

  def owner_buttons
    if h.current_user.id == object.user_id
      h.content_tag :div, class: "btn-group" do
        h.concat h.link_to "Edit", h.edit_recipe_review_path(review.recipe, review), remote: true, class: "btn button-full"
        h.concat h.link_to "Delete", h.recipe_review_path(object.recipe, review), method: :delete, data: { confirm: "Are you sure?" }, class: "btn button-full"
      end
    end
  end
end
