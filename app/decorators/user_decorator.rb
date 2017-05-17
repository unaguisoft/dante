class UserDecorator < Draper::Decorator
  delegate_all

  def name_and_email
    "#{user.name.humanize}  (#{user.email})"
  end

  private

  def user
    object
  end

end
