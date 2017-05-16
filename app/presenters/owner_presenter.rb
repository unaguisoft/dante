class OwnerPresenter
  
  def initialize(params:, current_user:)
    @params = params
    @user   = current_user
    @filter = filter
  end
  
  def owners
    @owners ||= filter.call.page(@params[:page]).decorate
  end
  
  def filter
    @filter ||= OwnerFilter.new(filter_params.merge({user: @user}))
  end
  
  private
  
  def filter_params
    if @params[:owner_filter]
      parameters = @params.require(:owner_filter).permit(:name, :email, :agent_id)
    end
    parameters || {}
  end
  
end
