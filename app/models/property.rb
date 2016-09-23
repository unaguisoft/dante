class Property < ApplicationRecord
  
  # -- Enum
  enum kind: { 'comercial': 0, 'residencial': 1 }
  enum status: { 'activo': 0, 'reservado': 1, 'vendido': 2, 'negociando': 3 }
  enum property_status: { 'sin_construir': 0, 'construyendo': 1, 'inhabilitado': 2, 'habilitado': 3 }
  enum currency: { ars: 0, usd: 1 }
  enum property_kind: { 
    'local': 0, # Local/Negocio
    'oficina': 1, # Oficina
    'piso': 2, # Piso
    'casa': 3, # Casa
    'departamento': 4, # Departamento
    'campo/quinta': 5, # Campo/Quinta
    'terreno': 6, # Terreno
    'loft': 7, # Loft
    'PH/dúplex': 8, # PH/Dúplex
    'cabaña': 9, # Cabaña
    'depósito': 10, # Depósito
    'cochera': 11, # Cochera
    'otro': 12 # Otro
  }
  
  # -- Associations
  belongs_to :city
  belongs_to :owner
  belongs_to :user
  
  # -- Validations
  validates :kind, presence: true
  validates :status, presence: true
  validates :property_status, presence: true
  validates :property_kind, presence: true
  validates :price, presence: true
  validates :currency,  presence: true
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
