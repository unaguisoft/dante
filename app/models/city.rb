class City < ApplicationRecord

  # -- Validations
  validates :name, presence: true
end
