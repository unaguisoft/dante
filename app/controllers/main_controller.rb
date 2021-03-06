class MainController < ApplicationController

  skip_before_action :require_login

  layout 'public'

  # GET /
  def home
    @presenter = HomePresenter.new(params)
  end

  # GET /test_map
  def test_map
    @address = params[:address]
    render :test_map, layout: nil
  end

  # GET /propiedades
  def properties
    filter = PropertyFilter.new(filter_params)
    @properties = filter.call(Property.for_web).includes(:city, :photos).decorate
  end

  # GET /propiedad/:id
  def property_details
    @presenter = PropertyForWebPresenter.new(params[:id])
  end

  # GET /blog
  def posts_for_web
    @posts = Post.order(created_at: :desc).page(params[:page]).per(3)
  end

  # GET /blog/:idj
  def post_for_web
    @post = Post.find(params[:id])
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

  # POST /enviar_tasacion
  def send_valuation
    PropertyMailer.valuation(params[:question]).deliver_now
    redirect_to valuation_path, notice: 'La solicitud ha sido enviada. Lo contactaremos a la brevedad'
  end

  # GET /inversion/:id
  def investment_details
    @investment = Investment.find(params[:id])
  end


  private

  def filter_params
    parameters = {}
    if params[:property_filter]
      parameters = params.require(:property_filter).permit(:title, :kind,
        :description, :city_id, :price_from, :price_to, :property_kind, :kind,
        :bankable)
    end
    parameters
  end

end
