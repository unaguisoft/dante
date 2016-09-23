class PropertyFeature < ApplicationRecord

  # -- Associations
  belongs_to :property
  belongs_to :feature

  # -- Validations
  validates :property_id, presence: true
  validates :feature_id, presence: true

end
