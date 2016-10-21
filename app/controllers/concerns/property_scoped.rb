module PropertyScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_property
  end

  private
    def set_property
      if params[:property_id]
        @property = Property.find(params[:property_id])
      end
    end
end
