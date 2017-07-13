class Recipe < ApplicationRecord
  paginates_per 4

  has_many :ingredients
  has_many :steps

  accepts_nested_attributes_for :ingredients,
                                reject_if:  :all_blank,
                                allow_destroy: true

  accepts_nested_attributes_for :steps,
                                reject_if: :all_blank,
                                allow_destroy: true

  validates :name, :description, :image, presence: true
  has_attached_file :image, styles: { medium: "360x270#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
