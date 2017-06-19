# --------------------------------
# FORM
# --------------------------------
class App.PropertyForm

  constructor: () ->
    @element = $('#js-photos')
    $('#js-progress-bar').hide()
    @bindEvents()
    @owner_modal = new App.OwnerModalForm('#js-modal', @onOwnerCreated)

  # ---- Binding de Eventos
  bindEvents: () ->
    $("[data-behavior~=mapTester]").click (e)=>
      e.preventDefault()
      @testMap()

    $("[data-behavior~=searchOwner]").ajaxSelect()
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
  removePhoto: (photo_id)->
    $("#photo_#{photo_id}").remove()

  onOwnerCreated: (data) ->
    $('input[data-behavior~=searchOwner]').select2('data', data)

  testMap: ->
    address = $('#js-map-address').val()
    if address == ''
      App.flash_snackbar_render({error: 'Ingrese una dirección'})
      $('#js-map-address').focus()
      return false

    url = "/test_map?address=#{address}"
    $.ajax
      url: url
    .done (data)->
      modal = $('#js-modal')
      modal.find('.modal-content').html(data)
      modal.modal("show")

# ---------------------------------



# --------------------------------
# --------------------------------
$(document).on "turbolinks:load page:change", ->
  App.property_form = new App.PropertyForm() unless $(".properties.new, .properties.edit, .properties.create, .properties.update, .properties.upload_photos").length == 0
