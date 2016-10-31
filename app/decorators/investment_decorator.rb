class InvestmentDecorator < Draper::Decorator
  delegate_all

  def identification
    "##{investment.id}"
  end

  def address
    "#{investment.address.capitalize}"
  end
  
  def public?
    investment.should_display_on_web ? 'Si' : 'No'
  end

  private

  def investment
    object
  end
end
