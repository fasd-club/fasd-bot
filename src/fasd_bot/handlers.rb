require 'fasd_bot/utils'

HANDLERS = {
  /^-fasdeia- .+$/i => 'add_sticker',
  /^-fasd- healthcheck$/i => 'healthcheck_reply'
}.freeze

def add_sticker(bot, message)
  return add_sticker_from_picture(bot, message) if message.reply_to_message&.photo
  return add_sticker_from_sticker(bot, message) if message.reply_to_message&.sticker
end

def add_sticker_from_picture(bot, message)
  file_id = message.reply_to_message.photo.max_by { |f| f.file_size }.file_id
  file_result = bot.api.get_file(file_id: file_id)['result']
  image_url = get_image_url(file_result)
  resized_image = get_resized_image(image_url)

  puts bot.api.add_sticker_to_set(
    user_id: 184425111,
    name: 'FASDSticker_by_UmBeloBot',
    png_sticker: Faraday::UploadIO.new(resized_image, 'image/png'),
    emojis: message.text.split(' ')[1]
  )
rescue => e
  bot.api.send_message(
    chat_id: message.chat.id,
    text: "Que morte horrível soldado. #{e.message}."
  )
end

def healthcheck_reply(bot, message)
  bot.api.send_message(
    chat_id: message.chat.id,
    text: 'Tô aqui carniça'
  )
end

def add_sticker_from_sticker(bot, message)
  #no-op @todo add a sticker
end
