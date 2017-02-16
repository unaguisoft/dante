class MainController < ApplicationController

  skip_before_action :require_login

  layout 'public'

  # GET /
  def home
    @presenter = HomePresenter.new(params)
  end

  # GET /propiedades
  def properties
    filter = PropertyFilter.new(filter_params)
    @properties = filter.call(Property.for_web).decorate
  end

  # GET /propiedad/:id
  def property_details
    @presenter = PropertyForWebPresenter.new(params[:id])
  end

  # POST /propiedad/:id/enviar_consulta
  def send_question
    property = Property.find(params[:id])
    PropertyMailer.question(property, params[:question]).deliver_now
    redirect_to property_details_path(property), notice: 'El correo ha sido enviado'
  end

  # POST /enviar_contacto
  def send_contact
    PropertyMailer.contact(params[:question]).deliver_now
    redirect_to contact_path, notice: 'El correo ha sido enviado'
  end

  # GET /inversion/:id
  def investment_details
    @investment = Investment.find(params[:id])
  end


  private

  def filter_params
    if params[:property_filter]
      parameters = params.require(:property_filter).permit(:title, :kind,
        :description, :city_id, :price_from, :price_to, :property_kind, :kind)
    end
  end

end
