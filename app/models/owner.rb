class Owner < ApplicationRecord
  
  # -- Alias
  alias_attribute :agent_id, :user_id
  alias_attribute :agent, :user
  
  # -- Associations
  belongs_to :user
  
  # -- Scopes
  scope :search, ->(term) {
    where('first_name ilike :term or last_name ilike :term', term: "%#{term}%")
  }
  
  # -- Validations
  validates :agent, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :cellphone, presence: true
  validates :email, presence: true
  
  def to_s
    "#{last_name}, #{first_name}"
  end
  
end
