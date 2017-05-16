class OwnerFilter
  include ActiveModel::Model
  attr_accessor :name, :email, :agent_id, :user
  
  def call
    owners = (@user.role == "admin") ? Owner.all : Owner.all_from_user(@user.id)
    owners = owners.where('first_name ILIKE :term OR last_name ILIKE :term', term: "%#{@name}%") if @name.present?
    owners = owners.where('email ILIKE ?', "%#{@email}%") if @email.present?
    owners = owners.where(user_id: @agent_id) if @agent_id.present?
    
    owners
  end
end
