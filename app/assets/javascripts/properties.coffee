# --------------------------------
# FORM
# --------------------------------
class App.PropertyForm

  constructor: () ->
    @bindEvents()
    @owner_modal = new App.OwnerModalForm('#js-modal', @onOwnerCreated)

  # Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=searchOwner]").ajaxSelect()
  
  onOwnerCreated: (data) ->
    $('input[data-behavior~=searchOwner]').select2('data', data)
# ---------------------------------



# --------------------------------
# --------------------------------
$(document).on "turbolinks:load page:change", ->
  property_form = new App.PropertyForm() unless $(".properties.new, .properties.edit, .properties.create, .properties.update").length == 0
