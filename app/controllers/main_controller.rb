class MainController < ApplicationController

  layout 'public'

  def home
    @presenter = HomePresenter.new(params)
  end

end
