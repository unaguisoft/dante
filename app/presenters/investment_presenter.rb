class InvestmentPresenter

  def initialize(params)
    @params = params
    @filter = filter
  end

  def investments
    @investments ||= filter.call.page(@params[:page]).decorate
  end

  def filter
    @filter ||= InvestmentFilter.new(filter_params)
  end

  private

  def filter_params
    if @params[:investment_filter]
      parameters = @params.require(:investment_filter).permit(:id, :title, :address)
    end

    parameters || {}
  end

end
