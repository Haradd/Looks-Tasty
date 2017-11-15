ActiveAdmin.register_page "Dashboard" do
  menu priority: 1
  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recently added Recipes" do
          table_for Recipe.includes(:user).order("id desc").limit(10) do
            column("Name", &:name)
            column("Author") { |recipe| recipe.user.username }
            column("Reviews count", &:reviews_count)
            column("Average rating") { |recipe| recipe.reviews.average(:rating).round(2) }
          end
        end
      end

      column do
        panel "New Users" do
          table_for User.order("id desc").limit(10).each do |_user|
            column(:username)
            column(:email) { |user| link_to(user.email, admin_user_path(user)) }
          end
        end
      end
    end

    columns do
      column do
        div do
          br
          text_node %(<iframe src="https://rpm.newrelic.com/public/charts/6VooNO2hKWB"
                              width="500" height="300" scrolling="no" frameborder="no">
                      </iframe>).html_safe
        end
      end
    end
  end
end
