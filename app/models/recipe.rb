class Recipe < ApplicationRecord
  paginates_per 4

  belongs_to :user
  belongs_to :category

  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy

  accepts_nested_attributes_for :ingredients,
                                reject_if:  :all_blank,
                                allow_destroy: true

  accepts_nested_attributes_for :steps,
                                reject_if: :all_blank,
                                allow_destroy: true

  validates :name,  :image, :ingredients, :steps, presence: true
  has_attached_file :image, styles: { big: "550x370#", medium: "360x270#", small: "100x90#" },
                            default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\z}

  scope :search, lambda { |word|
    where("name LIKE ?", "%#{word}%") if word.present?
  }

  scope :by_category, lambda { |category|
    if category.blank?
      order("created_at DESC")
    else
      joins(:category)
        .where(categories: { name: category })
        .order("recipes.created_at DESC")
    end
  }
end
