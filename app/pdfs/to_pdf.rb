class ToPdf < Prawn::Document

  require 'prawn/icon'

  METADATA = {
    Title: "Datos de Propiedad",
    Author: "Dante Estudio Inmobiliario",
    Creator: "Dante Estudio Inmobiliario",
    CreationDate: Time.now
  }

  def initialize(view, page_layout = :portrait, page_size = 'A4')
    super(page_size: page_size, page_layout: page_layout, info: METADATA)
    add_fonts()

    @view = view
    font 'Helvetica', size: 10
  end

  def h1(text, *args)
    options = args.extract_options!
    options[:align] ||= :center
    options[:style] ||= :bold

    text text, size: 30, style: options[:style], align: options[:align]
    move_down 10
  end

  def h2(text, *args)
    options = args.extract_options!
    options[:align] ||= :center
    options[:style] ||= :bold

    text text, size: 25, style: options[:style], align: options[:align]
    move_down 10
  end

  def h3(text, *args)
    options = args.extract_options!
    options[:align] ||= :center
    options[:style] ||= :bold

    text text, size: 20, style: options[:style], align: options[:align]
    move_down 10
  end

  def h4(text, *args)
    options = args.extract_options!
    options[:align] ||= :center
    options[:style] ||= :bold

    text text, size: 16, style: options[:style], align: options[:align]
    move_down 10
  end

  def h5(text, *args)
    options = args.extract_options!
    options[:align] ||= :center
    options[:style] ||= :bold

    text text, size: 14, style: options[:style], align: options[:align]
    move_down 10
  end

  def h6(text, *args)
    options = args.extract_options!
    options[:align] ||= :center
    options[:style] ||= :bold

    text text, size: 12, style: options[:style], align: options[:align]
    move_down 10
  end

  def p(text, *args)
    options = args.extract_options!
    options[:align] ||= :left
    options[:style] ||= :normal
    options[:size] ||= 11
    options[:color] ||= '000000'
    text text, size: options[:size], style: options[:style], align: options[:align], color: options[:color], inline_format: true
  end

  def field(label, content)
    text "<b>#{label}: </b> #{content.presence || '--' }", inline_format: true, size: 12
    move_down 5
  end

  def i(_icon, _text, *args)
    options = args.extract_options!
    options[:size]  ||= 13
    options[:align] ||= :left
    options[:style] ||= :normal
    options[:color] ||= 'A33234'
    icon "<icon size='#{options[:size]}' color='#{options[:color]}'>#{_icon}</icon> <font size='14'> #{_text}</font>", inline_format: true, align: options[:align], style: options[:style]
  end

  # ----------------------------------------------------------------------
  # TABLE
  # ----------------------------------------------------------------------
  def display_table(data, colors=[])
    table(data, cell_style: { borders: [], padding: 0 }, width: 520, header: true, row_colors: colors ) do |table|
      table.row(0).font_style = :bold
      table.row(0..data.count).padding    = 4
      table.row(0).borders    = [:top, :bottom]
      table.row(0).padding    = 4
    end
    move_down 10
  end


  # ----------------------------------------------------------------------
  # MISC
  # ----------------------------------------------------------------------

  def to_currency(a_value)
    @view.number_to_currency(a_value)
  end

  def display_separator
    move_down 10
    stroke_horizontal_rule
    move_down 10
  end

  def img(url, *args)
    options = args.extract_options!
    left   = options[:left] || 0
    top    = options[:top] || 0
    width  = options[:width] || 200
    height = options[:height] || 200
    image url, :at => [left, top], :width => width, :height => height
  end

  def landscape_logo(url)
    image url, :at => [100,745], :width => 400
  end

  def uploaded_file_path(url)
    File.join(Rails.root, 'public', url)
  end

  def image_path(name)
    File.join(Rails.root, 'app', 'assets', 'images', name)
  end

  private

  def add_fonts
    font_families.update("Serifa" => {
      :normal => Rails.root.join("app/assets/fonts/SERIFAL.TTF"), #Light
      :italic => Rails.root.join("app/assets/fonts/SERIFAT.TTF"), #Thin
      :bold => Rails.root.join("app/assets/fonts/SERIFAN.TTF"), #Bold
      :extra_bold => Rails.root.join("app/assets/fonts/SERIFAB.TTF") #Big Bold
    })
  end

end
