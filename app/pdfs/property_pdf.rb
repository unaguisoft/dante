class PropertyPdf < ToPdf

  PHOTO_PATH = 'system/dragonfly/development/'

  def initialize(property, view)
    super view, :portrait, 'A4'
    @property = property.decorate
    @agent    = property.user.decorate 
    @view     = view

    stroke_axis
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
    move_cursor_to 125
    pad_top(5) { p "<b>Precio:</b> #{@property.price}", size: 16 }
    fill_color "A33234"
    fill_rectangle [0, 100], 530, 5
    fill_color "000000"
    move_cursor_to 90

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
      i 'fa-mobile', '+54 (0221) 15 562 4435', size: 15, align: :right, style: :bold
      move_up 2
      i 'fa-envelope', 'gonzagaldamez@gmail.com', size: 12, align: :right, style: :bold
    end
    move_down 18
    p " ------- Prof. Responsable Alejo Dante Col. 7254 ------- ", align: :center, size: 11
  end

  # ----------------------------- CONTENT
  def property_title
    h3 @property.title.truncate(50), :bold
  end

  def property_images
    principal_photo = @property.photos.first
    photos = @property.photos.where.not(id: principal_photo.id) if principal_photo

    c = cursor
    if principal_photo
      img uploaded_file_path("#{PHOTO_PATH}#{principal_photo.file_uid}"), left: 0, top: c, width: 190, height: 156
    end

    build_thumbnails(c, photos) if photos.present?
  end

  def build_thumbnails(cursor, photos=[])
    photos = photos.sample(6)
    origin = 200

    photos.first(3).each do |photo|
      photo = photos.delete(photo)
      img uploaded_file_path("#{PHOTO_PATH}#{photo.file_uid}"), left: origin, top: cursor, width: 103, height: 75
      origin += 110
    end

    move_down 6

    origin = 200
    photos.last(3).each do |photo|
      photo = photos.delete(photo)
      img uploaded_file_path("#{PHOTO_PATH}#{photo.file_uid}"), left: origin, top: cursor - 80, width: 103, height: 75
      origin += 110
    end
  end

  def property_address
    display_separator
    p "<b>Dirección:</b> #{@property.complete_address} "
  end

  def property_information
    display_separator
    p "<b>Dormitorios:</b> #{@property.number_of_bedrooms} "\
      '                                                    '\
      "<b>Baños:</b>  #{@property.number_of_bathrooms}"
    move_down 5
    p "<b>Sup. Total:</b> #{@property.total_area} "\
      '                                             '\
      "<b>Sup. Cubierta:</b>  #{@property.built_area} "
  end

  def property_description
    display_separator
    h5 "Detalle", align: :center
    p "#{@property.description}".truncate(700) 
  end

  def property_features
    display_separator
    h5 "Características", align: :center
    p "Cochera"\
      '   |   '\
      "Calefacción Central"\
      '   |   '\
      "Estufa hogar"\
      '   |   '\
      "Anafe"
  end

end
