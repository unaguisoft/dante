class PropertyFeature < ApplicationRecord

  # -- Associations
  belongs_to :property
  belongs_to :feature

  # -- Validations
  validates :property, presence: true
  validates :feature, presence: true

end
