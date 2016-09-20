class Feature < ApplicationRecord
  
  # -- Validations
  validates :name, presence: true
end
