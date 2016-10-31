class InvestmentFilter

  include ActiveModel::Model

  attr_accessor :id, :title, :address

  def call
    investments = Investment.all
    investments = investments.where(id: @id) if @id.present?
    investments = investments.where('title ILIKE ?', "%#{@title}%") if @title.present?
    investments = investments.where('address ILIKE ?', "%#{@address}%") if @address.present?

    investments
  end

  private

end
