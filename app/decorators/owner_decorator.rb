class OwnerDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{last_name}, #{first_name}"
  end
  
  def email
    owner.email.blank? ? '-' : owner.email
  end
  
  def agent
    owner.agent.name
  end
  
  def telephones
    if owner.phones.present? 
      "#{owner.cellphone} / #{owner.phones}"
    else
      "#{owner.cellphone}"
    end
  end

  private
  
  def owner
    object
  end
end
