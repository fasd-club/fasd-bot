require 'mini_magick'

def get_image_url(file_result)
  'https://api.telegram.org/file/bot'+TOKEN+'/'+file_result['file_path']
end

def get_resized_image(image_url)
  image = MiniMagick::Image.open(image_url)
  image.resize '512x512'
  image.format 'png'
  image.path
end
