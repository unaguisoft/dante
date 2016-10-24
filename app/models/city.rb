class City < ApplicationRecord

  # -- Scopes
  scope :by_name, -> { order(:name) }

  # -- Validations
  validates :name, presence: true

  def to_s
    "#{name}"
  end
end
