class PropertyPdf < ToPdf

  PHOTO_PATH = 'system/dragonfly/development/'

  def initialize(property, view)
    super view, :portrait, 'A4'
    @property = property.decorate
    @agent    = property.user.decorate 
    @view     = view
   
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
    move_cursor_to 665
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
    move_cursor_to 110
    pad_top(5) { p "<b>Precio:</b> #{@property.price}", size: 16 }
    fill_color "A33234"
    fill_rectangle [0, 85], 530, 5
    fill_color "000000"
    move_cursor_to 70

    c = cursor
    bounding_box([0, c], width: 290) do
      p 'www.danteestudioinmobiliario.com.ar', size: 9
      move_down 3
      p "Dante Estudio Imobiliario", size: 9
      move_down 3
      p 'Diag 74 Nro 2083, La Plata (1900)', size: 9
      move_down 3
      p "Alejo Dante Col. 7254", size: 9
    end
    bounding_box([325, c], width: 200) do
      p "#{@agent.name}", size: 16, align: :right
      move_down 5
      p 'Asesor Comercial', size: 10, align: :right
      move_down 5
      p 'Cel.: 221 5624435', size: 10, align: :right
      move_down 5
      p 'gonzagaldamez@gmail.com', size: 10, align: :right
    end
  end

  # ----------------------------- CONTENT
  def property_title
    h3 @property.title.truncate(50)
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
