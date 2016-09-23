class City < ApplicationRecord

  # -- Validations
  validates :name, presence: true
  
  def to_s
    "#{name}"
  end
end
