class Post < ApplicationRecord

  # -- Associations
  validates :title, presence: true
  validates :subtitle, presence: true
  validates :body, presence: true

  # -- Misc
  dragonfly_accessor :image

end
