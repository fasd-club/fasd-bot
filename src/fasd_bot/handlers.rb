require 'fasd_bot/utils'
require 'fasd_bot/config'

HANDLERS = {
  /^-fasdeia- .+$/i => 'add_sticker_handler',
  /^-fasd- healthcheck$/i => 'healthcheck_reply',
  /^-fasd- (quarta|quartas)$/i => 'reply_quarta',
}.freeze

def get_resized_image(bot, file_id)
  file_result = bot.api.get_file(file_id: file_id)['result']
  image_url = get_image_url(file_result)
  resized_image = resize_image(image_url)
end

def add_sticker_handler(bot, message)
  return add_sticker(bot, message) do
    message.reply_to_message.photo.max_by { |f| f.file_size }.file_id
  end if message.reply_to_message&.photo&.any?

  return add_sticker(bot, message) do
    message.reply_to_message.sticker.file_id
  end if message.reply_to_message&.sticker
rescue => e
  bot.api.send_message(
    chat_id: message.chat.id,
    text: "Que morte horrível soldado. #{e.message}."
  )
end

def add_sticker(bot, message)
  file_id = yield
  resized_image = get_resized_image(bot, file_id)

  bot.api.add_sticker_to_set(
    user_id: Config::BOT_OWNER_ID,
    name: Config::BOT_NAME,
    png_sticker: Faraday::UploadIO.new(resized_image, 'image/png'),
    emojis: message.text.split(' ')[1]
  )

  bot.api.send_message(
    chat_id: message.chat.id,
    text: "Sticker autárquico adicionado com sucesso."
  )
end

def healthcheck_reply(bot, message)
  bot.api.send_message(
    chat_id: message.chat.id,
    text: 'Tô aqui carniça!'
  )
end

def reply_quarta(bot, message)
  bot.api.send_message(
    chat_id: message.chat.id,
    text: """
    Ode às Quartas-feiras

Ó, quartas-feiras
Por que me judiastes?
Ó, quartas-feiras
Por que sois tão distantes
Tanto do final de semana passado
Quanto do que está por vir
Ó, quartas-feiras
Por que não passastes...
    """
  )
end
