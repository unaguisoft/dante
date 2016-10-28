class MainController < ApplicationController

  skip_before_action :require_login

  layout 'public'

  # GET /
  def home
    @presenter = HomePresenter.new(params)
  end

  # GET /propiedades
  def properties
    @properties = Property.for_web.decorate
  end

  # GET /propiedad/:id
  def property_details
    @presenter = PropertyForWebPresenter.new(params[:id])
  end

end
