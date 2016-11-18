module InvestmentScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_investment
  end

  private
    def set_investment
      if params[:investment_id]
        @investment = Investment.find(params[:investment_id])
      end
    end
end
