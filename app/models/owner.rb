class Owner < ApplicationRecord
  
  # -- Alias
  alias_attribute :agent, :user
  
  # -- Associations
  # belongs_to :agent, class: 'User', foreign_key: 'user_id'
  belongs_to :user
  
  # -- Validations
  validates :agent, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :cellphone, presence: true
  validates :email, presence: true
end
