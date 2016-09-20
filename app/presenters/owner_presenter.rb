class OwnerPresenter
  
  def initialize(params)
    @params = params
    @filter = filter
  end
  
  def owners
    @owners ||= filter.call.page(@params[:page]).decorate
  end
  
  def filter
    @filter ||= OwnerFilter.new(filter_params)
  end
  
  private
  
  def filter_params
    if @params[:owner_filter]
      parameters = @params.require(:owner_filter).permit(:name, :email, :agent_id)
    end
    parameters || {}
  end
  
end