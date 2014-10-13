module WatermarkDocument
  extend ActiveSupport::Concern

  require 'RMagick'
  require 'rqrcode_png'
  # require 'image_optim'

  def setup_path
    # Setting up paths for processing
    @original_file = file
    if @original_file
      @tmp_file_path = Rails.root.join("public", "uploads", "tmp", "#{file.file.filename}")    # /X/Y/Z/1.pdf
      @tmp_file_basedir = @tmp_file_path.dirname  #  /X/Y/Z
      @tmp_file_basename = @tmp_file_path.basename    #   1.pdf
      @tmp_file_identifier = @tmp_file_basename.to_s.split(".")[0]    # 1

      ### Path for output of qrcode, label and pdf => png
      @png_path = Rails.root.join("public", "uploads", "tmp", "png")
      @png_name_template = ""
      @label_path = Rails.root.join("public", "uploads", "tmp", "label")
      @qr_path = Rails.root.join("public", "uploads", "tmp", "qr")
      @marked_png_path = Rails.root.join("public", "uploads", "tmp", "marked_png")
      @pdf_path = Rails.root.join("public", "store", "files")
      @file_location = Pathname.new("/store/files/#{file.file.filename}")
      @thumbnail_location = Rails.root.join("public", "storage", "files", "thumbnail")
    end
  end

  def watermarked_school_document
    setup_path
    check_or_create_dirs
    check_or_empty_dirs
    copy_file_for_process
    tmp_to_png
    generate_qr_code("SD-#{id}", {height: 150, width: 150})
    generate_label(generate_label_texts("SD", categories))
    stamp_png_files
    to_pdf
    update_column(:file_location, @file_location.to_path)
  end

  def watermarked_public_exam
    setup_path
    check_or_create_dirs
    check_or_empty_dirs
    copy_file_for_process
    tmp_to_png
    generate_qr_code("PE-#{id}", {height: 150, width: 150})
    generate_label(generate_label_texts("PE", ""))
    stamp_png_files
    to_pdf
    update_column(:file_location, @file_location.to_path)
  end


  def check_or_create_dirs
    # Check the existence of dirs, if not create it.
    FileUtils.mkdir_p(@tmp_file_basedir) unless Dir.exist?(@tmp_file_basedir)
    FileUtils.mkdir_p(@png_path) unless Dir.exist?(@png_path)
    FileUtils.mkdir_p(@label_path) unless Dir.exist?(@label_path)
    FileUtils.mkdir_p(@qr_path) unless Dir.exist?(@qr_path)
    FileUtils.mkdir_p(@marked_png_path) unless Dir.exist?(@marked_png_path)
    FileUtils.mkdir_p(@pdf_path) unless Dir.exist?(@pdf_path)
    FileUtils.mkdir_p(@thumbnail_location) unless Dir.exist?(@thumbnail_location)
  end

  def check_or_empty_dirs
    dirs = [@tmp_file_basedir, @png_path, @label_path, @qr_path, @marked_png_path]
    dirs.each do |dir|
      entries = Dir.entries(dir).sort[2..-1]      ## Filtering out "." and ".."
      # entries.each do |entry|

      FileUtils.rm_r Dir.glob("#{dir}/*.*") if entries.size > 0
    end
  end

  def copy_file_for_process
      FileUtils.cp(@original_file.file.path, @tmp_file_path.to_path)
  end

  def tmp_to_png
    `convert -density 200 -size 800x600 #{@tmp_file_path} #{@png_path}/#{@tmp_file_identifier}-%03d.png`
  end

  def

  def generate_qr_data
    file_id = id
    "#{file_id}"
  end

  def generate_qr_code(string, size)
    qr = RQRCode::QRCode.new(string, :size => 4, :level => :h)
    png = qr.to_img
    png.resize(size[:height], size[:width]).save("#{@qr_path}/#{@tmp_file_identifier}-qr.png")
  end

  def generate_label_texts(format, categories)
    @file_id = "#{format}-#{id}"

    unless categories.size == 0
      @categories_collection = categories.map {|c| c.name }
      @categories_name = @categories_collection.join(", ")
    else
      @categories_name = "Not specified"
    end
    @label_string = "ID: #{@file_id}\nCategories: #{@categories_name[0..40]}"
  end

  def generate_label(contents)
    canvas = Magick::Image.new(800, 300) do
      self.background_color = "none"
    end
    gc = Magick::Draw.new
    gc.pointsize(18)
    gc.text(10, 50, contents)
    gc.draw(canvas)
    output_name = "#{@label_path}/#{@tmp_file_identifier}-label.png"
    canvas.write(output_name)
  end

  def stamp_png_files
    qr_x_coord = 20
    qr_y_coord = 20
    label_x_coord = qr_x_coord + 150
    label_y_coord = qr_y_coord

    png_files = Dir.glob("#{@png_path}/*.*")
    # image_optim = ImageOptim.new
    # png_files.each do |png|
    #   image_optim.optimize_image!(png)
    # end
    qr_file = ChunkyPNG::Image.from_file(@qr_path.join("#{@tmp_file_identifier}-qr.png"))

    label_file = @label_path.join("#{@tmp_file_identifier}-label.png")
    pdf_label = ChunkyPNG::Image.from_file(label_file)

    png_files.each do |png|
      pdf_template = ChunkyPNG::Image.from_file(png)
      pdf_template.compose!(qr_file, qr_x_coord, qr_y_coord)
      pdf_template.compose!(pdf_label, label_x_coord, label_y_coord)
      pdf_template.save("#{@marked_png_path}/#{png.split("/").last}", :fast_rgba)
    end
  end

  def to_pdf
    marked_png_files = Dir.glob("#{@marked_png_path}/*.*")
    image_lists = Magick::ImageList.new(*marked_png_files)
    image_lists.write("#{@pdf_path}/#{@original_file.file.filename}")
  end

  handle_asynchronously :watermarked_school_document
  handle_asynchronously :watermarked_public_exam
end
