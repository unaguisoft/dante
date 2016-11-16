class InvestmentPhoto < ApplicationRecord

  # -- Associations
  belongs_to :investment

  # -- Misc
  dragonfly_accessor :file

end
