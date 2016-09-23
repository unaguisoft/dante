class PropertyPresenter
  
  def initialize(params)
    @params = params
    @filter = filter
  end
  
  def properties
    @properties ||= filter.call.page(@params[:page]).decorate
  end
  
  def filter
    @filter ||= PropertyFilter.new(filter_params)
  end
  
  private
  
  def filter_params
    if @params[:property_filter]
      parameters = @params.require(:property_filter).permit(
        :kind, :status, :price, :currency, :shoul_display_price, :expenses_cost,
        :property_status, :property_kind, :year, :number, :built_area, 
        :semi_built_area, :total_area, :perimeter, :has_parking, :address, 
        :description, :title, :number_of_rooms, :number_of_bedrooms,
        :number_of_bathrooms, :number_of_toilets, :should_display_on_web,
        :should_highlight_on_web, :city_id, :owner_id, :user_id)
    end
    
    parameters || {}
  end
  
end