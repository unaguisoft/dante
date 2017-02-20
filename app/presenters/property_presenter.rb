class PropertyPresenter

  def initialize(params, current_user)
    @params       = params
    @current_user = current_user
    @filter       = filter
  end

  def properties
    @properties ||= filter.call.page(@params[:page]).decorate
  end

  def filter
    @filter ||= PropertyFilter.new(filter_params)
  end

  def highlighted_properties(limit=3)
    Property.highlighted.sample(limit)
  end

  private

  def filter_params
    if @params[:property_filter]
      parameters = @params.require(:property_filter).permit(:id, :title,
        :city_id, :property_kind, :kind, :price_from, :price_to, :user_id, :bankable)
      parameters = parameters.merge({current_user: @current_user})
    end

    parameters || {current_user: @current_user}
  end

end
