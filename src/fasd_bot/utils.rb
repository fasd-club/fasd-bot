require 'mini_magick'

module Utils
  def self.get_file_url(file)
    "https://api.telegram.org/file/bot#{Config::TOKEN}/#{file['result']['file_path']}"
  end

  def self.resize_image(file, dimensions = '512x512', format = 'png')
    image_url = get_file_url(file)
    img = MiniMagick::Image.open(image_url)
    img.resize dimensions
    img.format format
    img
  end
end
