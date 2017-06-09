class UserDecorator < Draper::Decorator
  delegate_all

  def name
    user.name.titleize
  end

  def name_and_email
    "#{user.name}  (#{user.email})"
  end

  private

  def user
    object
  end

end
