class Feature < ApplicationRecord
  
  # -- Validations
  validates :name, presence: true
  validates :name, uniqueness: true
end
