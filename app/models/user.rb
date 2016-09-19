class User < ApplicationRecord
  authenticates_with_sorcery!

  # -- Validations
  validates :password, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password, length: { minimum: 4 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true

end
