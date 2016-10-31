class Investment < ApplicationRecord

  # -- Scope
  scope :for_web, -> { where(should_display_on_web: true) }

  # -- Associations
  has_many :investment_photos, dependent: :destroy

  # -- Validations
  validates :title, presence: true
  validates :details, presence: true
  validates :address, presence: true

end
