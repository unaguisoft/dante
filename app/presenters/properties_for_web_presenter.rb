class PropertiesForWebPresenter

  def initialize(params)
    @params = params
    @filter = filter
  end

  def properties
    @properties ||= filter.call(Property.for_web).page(@params[:page]).decorate
  end

  def filter
    @filter ||= PropertyFilter.new(filter_params)
  end

  private

  def filter_params
    if @params[:property_filter]
      parameters = @params.require(:property_filter).permit(:id, :title,
        :city_id, :property_kind, :kind, :price_from, :price_to, :user_id)
    end

    parameters || {}
  end

end
