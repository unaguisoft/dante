# --------------------------------
# FORM
# --------------------------------
class App.InvestmentForm

  constructor: () ->
    @element = $('#js-investment-photos')
    $('#js-progress-bar').hide()
    @bindEvents()

  # ---- Binding de Eventos
  bindEvents: () ->
    $('#fileupload').fileupload
      dataType: 'script'
      start: ->
        $('#js-progress-bar').show()
        $('#js-progress-bar').find('.progress-bar').css('width', '0%')
      progressall: (e, data)->
        progress = parseInt(data.loaded / data.total * 100, 10)
        $('#js-progress-bar').find('.progress-bar').css('width', "#{progress}%")
      fail: ->
        App.flash_snackbar_render
          danger: 'Falló la carga de imágenes'
      always: ->
        $('#js-progress-bar').hide()

  # ---- Funciones
  removePhoto: (investment_photo_id)->
    $("#investment_photo_#{investment_photo_id}").remove()
# ---------------------------------



# --------------------------------
# --------------------------------
$(document).on "turbolinks:load page:change", ->
  App.investment_form = new App.InvestmentForm() unless $(".investments.new, .investments.edit, .investments.create, .investments.update, .investments.upload_investment_photos").length == 0
