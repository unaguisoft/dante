class MainController < ApplicationController
  
  skip_before_action :require_login

  layout 'public'

  def home
    @presenter = HomePresenter.new(params)
  end

  def properties
    @presenter = PropertiesForWebPresenter.new(params)
  end

end
