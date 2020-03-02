class Recipe < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: %i[slugged finders]

  belongs_to :user
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy

  accepts_nested_attributes_for :ingredients,
                                reject_if:  :all_blank,
                                allow_destroy: true

  accepts_nested_attributes_for :steps,
                                reject_if: :all_blank,
                                allow_destroy: true

  validates :name, :image, :ingredients, :steps, presence: true
  validates :name, length: { maximum: 80 }
  has_attached_file :image, styles: { big: "550x370#", medium: "360x270#", small: "100x90#" },
                            default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\z}

  scope :by_name, lambda { |word|
    where("lower(recipes.name) LIKE ?", "%#{word.downcase}")
  }

  scope :by_category, lambda { |category|
    if Category.all.pluck(:name).include? category
      joins(:category)
        .where(categories: { name: category })
    end
  }

  scope :by_sort, lambda { |option|
    if option == "popularity"
      order("reviews_count DESC")
    elsif option == "best"
      order("reviews_average DESC")
    else
      order("created_at DESC")
    end
  }

  def self.filter(params = {})
    recipes = Recipe.includes(:reviews)

    recipes = recipes.by_name(params[:search]) if params[:search].present?
    recipes = recipes.by_category(params[:category]) if params[:category].present?
    recipes = recipes.by_sort(params[:sort]) if params[:sort].present?

    if params[:ingredients_include] && params[:ingredients_exclude]
      include_ids = recipes.joins(:ingredients).where(ingredients: { name: params[:ingredients_include] }).uniq.pluck(:id)
      exclude_ids = recipes.joins(:ingredients).where(ingredients: { name: params[:ingredients_exclude] }).uniq.pluck(:id)
      recipes = Recipe.where(id: include_ids - exclude_ids)
    else
      recipes = recipes.joins(:ingredients).where(ingredients: { name: params[:ingredients_include] }) if params[:ingredients_include]
      recipes = recipes.joins(:ingredients).where.not(ingredients: { name: params[:ingredients_exclude] }) if params[:ingredients_exclude]
    end

    recipes
  end

  def slug_candidates
    [
      [:name],
      %i[name id]
    ]
  end

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end

end
