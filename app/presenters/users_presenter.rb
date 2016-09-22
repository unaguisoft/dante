class UsersPresenter

  def users
    @users ||= User.by_name.decorate
  end
end
