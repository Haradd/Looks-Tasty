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

  scope :search_with, lambda { |word|
    where("name LIKE ?", "%#{word}%") if word.present?
  }

  scope :by_category, lambda { |category|
    if Category.all.pluck(:name).include? category
      joins(:category)
        .where(categories: { name: category })
    end
  }

  scope :filter_by, lambda { |option|
    if option == "popularity"
      order("reviews_count DESC")
    elsif option == "best"
      order("reviews_average DESC")
    else
      order("created_at DESC")
    end
  }

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
