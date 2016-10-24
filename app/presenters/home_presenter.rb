class HomePresenter

  def initialize(params)
    @params = params
    @filter = filter
  end

  def filter
    @filter ||= PropertyFilter.new(filter_params)
  end

  def cities
    City.all
  end

  def highlighted_properties(limit=3)
    Property.highlighted.sample(limit)
  end

  private

  def filter_params
    if @params[:property_filter]
      parameters = @params.require(:property_filter).permit(:description, :city_id, :kind, :property_kind, :price_from, :price_to)
    end
    parameters || {}
  end

end
