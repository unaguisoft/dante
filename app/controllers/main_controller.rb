class MainController < ApplicationController

  layout 'public'

  def home
    @presenter = HomePresenter.new(params)
  end

  def properties
    @presenter = PropertiesForWebPresenter.new(params)
  end

end
