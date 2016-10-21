class Photo < ApplicationRecord

  # -- Associations
  belongs_to :property

  # -- Misc
  dragonfly_accessor :file
  
  # # -- Validations
  # validates :file, presence: true
  # validates_size_of :file, maximum: 5120.kilobytes,
  #                   message: "no debe superar los 5 MB", if: :image_changed?
  #
  # validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :bmp], case_sensitive: false,
  #                    message: "debe ser .jpeg, .jpg, .png, .bmp", if: :image_changed?
end
