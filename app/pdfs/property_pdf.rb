class PropertyPdf < ToPdf

  IMAGES_PATH = ENV['IMAGES_PATH']

  def initialize(property, view)
    super view, :portrait, 'A4'
    @property = property.decorate
    @agent    = property.user.decorate 
    @view     = view

    font "Serifa"
    header
    move_down 20
    content
    move_down 10
    footer
  end

  private

  def header
    bounding_box([0, cursor], width: 590) do
      image image_path('sale_logo.png'), :width => 530
    end
  end

  def content
    move_cursor_to 670
    property_title
    move_cursor_to 635
    property_images
    move_cursor_to 475
    property_address
    move_cursor_to 445
    property_information
    move_cursor_to 390
    property_description
    move_cursor_to 250
    property_features
  end

  def footer
    move_cursor_to 130
    pad_top(5) { p "<b>Precio:</b> #{@property.price}", size: 16 }
    fill_color "A33234"
    fill_rectangle [0, 105], 530, 5
    fill_color "000000"
    move_cursor_to 95

    c = cursor
    bounding_box([0, c], width: 290) do
      p "Dante Estudio Imobiliario", size: 15, style: :bold
      move_up 6
      i 'fa-globe', 'www.danteestudioinmobiliario.com.ar', style: :italic
      move_up 1
      i 'fa-map-marker', 'Diag 74 Nro 2083, La Plata (1900)', style: :italic
      move_down 3
      i 'fa-phone', '(0221) 423 0180', style: :italic
      move_down 8
      # p "Alejo Dante Col. 7254", size: 9
    end
    bounding_box([325, c], width: 200) do
      p "#{@agent.name}", size: 16, align: :right, style: :bold
      move_down 2
      p 'Asesor Comercial', size: 12, align: :right, style: :bold
      move_up 6
      i 'fa-phone', '(0221) 423 0180', size: 15, align: :right, style: :bold
      move_up 2
      i 'fa-envelope', "#{@agent.email}", size: 12, align: :right, style: :bold
    end
    move_cursor_to 13
    c = cursor
    stroke_color "AAAAAA"
    stroke_horizontal_line 0, 160, at: c - 6
    stroke_horizontal_line 365, 530, at: c - 6
    move_cursor_to c
    p " Prof. Responsable Alejo Dante Col. 7254 ", align: :center, size: 11
  end

  # ----------------------------- CONTENT
  def property_title
    h3 @property.title.truncate(50), style: :extra_bold
  end

  def property_images
    principal_photo = @property.photos.first
    photos = @property.photos.where.not(id: principal_photo.id) if principal_photo

    c = cursor
    if principal_photo
      img uploaded_file_path("#{IMAGES_PATH}#{principal_photo.file_uid}"), left: 0, top: c, width: 190, height: 156
    end

    build_thumbnails(c, photos) if photos.present?
  end

  def build_thumbnails(cursor, photos=[])
    photos = photos.sample(6)
    origin = 200

    photos.first(3).each do |photo|
      photo = photos.delete(photo)
      img uploaded_file_path("#{IMAGES_PATH}#{photo.file_uid}"), left: origin, top: cursor, width: 103, height: 75
      origin += 110
    end

    move_down 6

    origin = 200
    photos.last(3).each do |photo|
      photo = photos.delete(photo)
      img uploaded_file_path("#{IMAGES_PATH}#{photo.file_uid}"), left: origin, top: cursor - 80, width: 103, height: 75
      origin += 110
    end
  end

  def property_address
    display_separator
    field "Dirección", @property.complete_address
  end

  def property_information
    display_separator
    bounding_box([0, 435], width: 175, height: 55) do
      move_down 10
      field "Dormitorios", @property.number_of_bedrooms
      field "Sup. Cubierta", @property.built_area
    end
    bounding_box([175, 435], width: 175, height: 55) do
      move_down 10
      field "Baños", @property.number_of_bathrooms
      field "Sup. Total", @property.total_area
    end
  end

  def property_description
    display_separator
    h5 "Detalle", align: :center
    p "#{@property.description}".truncate(700) 
  end

  def property_features
    display_separator
    features = @property.features.join("   |   ")
    bounding_box([0, 230], width: 530, height: 100) do
      h5 "Características", align: :center
      p "#{features}"
    end
  end

end
