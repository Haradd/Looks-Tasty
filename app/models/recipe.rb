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

  validates :name, presence: true
  validates :name, length: { maximum: 80 }
  has_attached_file :image, styles: { big: "550x370#", medium: "360x270#", small: "100x90#" },
                            default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\z}

  scope :by_name, lambda { |word|
    where("lower(recipes.name) LIKE ?", "%#{word.downcase}")
  }

  scope :by_category, lambda { |category|
    if Category.all_cached.pluck(:name).include? category
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
    recipes = Recipe.all
    recipes = recipes.by_name(params[:search]) if params[:search].present?
    recipes = recipes.by_category(params[:category]) if params[:category].present?
    recipes = recipes.by_sort(params[:sort]) if params[:sort].present?

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
