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

  def first_photo_url(size='100x100')
    if investment_photos.empty?
      "http://placehold.it/#{size}"
    else
      investment_photos.first.file.thumb("#{size}#").url
    end
  end

  private

  def investment
    object
  end
end
