class Feature < ApplicationRecord

  has_many :property_features
  has_many :properties, through: :property_features

  # -- Validations
  validates :name, presence: true
  validates :name, uniqueness: true


  def name=(s)
    s.nil? ? super(s) : super(s.capitalize)
  end
end
