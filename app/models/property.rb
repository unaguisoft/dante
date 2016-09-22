class Property < ApplicationRecord
  
  # -- Enum
  enum kind: { commercial: 0, residential: 1 }
  enum status: { active: 0, reserved: 1, sold: 2, negotiating: 3 }
  enum property_status: { unbuilt: 0, building: 1, not_enabled: 2, enabled: 3 }
  enum currency: { ars: 0, usd: 1 }
  enum property_kind: { 
    shop: 0, # Local/Negocio
    office: 1, # Oficina
    floor: 2, # Piso
    house: 3, # Casa
    apartment: 4, # Departamento
    countryside_farm: 5, # Campo/Quinta
    land: 6, # Terreno
    loft: 7, # Loft
    duplex: 8, # PH/Dúplex
    bungalow: 9, # Cabaña
    deposit: 10, # Depósito
    garage: 11, # Cochera
    other: 12 # Otro
  }
  
  # -- Associations
  belongs_to :city
  belongs_to :owner
  belongs_to :user
  
  # -- Validations
  validates :kind, presence: true
  validates :status, presence: true
  validates :price_in_cents, presence: true
  validates :currency,  presence: true
  validates :property_status, presence: true
  validates :property_kind, presence: true
  validates :built_area, presence: true
  validates :semi_built_area, presence: true
  validates :perimeter, presence: true
  validates :has_parking, presence: true
  validates :address, presence: true
  validates :title, presence: true
  validates :number_of_bedrooms, presence: true
  validates :number_of_bathrooms, presence: true
  validates :city, presence: true
  validates :owner, presence: true
  validates :user, presence: true
  
  
  
  # Para usar field_in_cents, etc.
  def self.attributes_in_cents
    ['price', 'expenses_cost']
  end

  include IntegerInCents
end
