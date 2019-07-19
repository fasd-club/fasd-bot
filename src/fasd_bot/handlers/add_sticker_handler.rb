require 'fasd_bot/config'
require 'fasd_bot/utils'

module AddStickerHandler
  def self.handle(bot, message)
    resized_image =
      get_file_id(message)
        .then { |file_id| bot.api.get_file(file_id: file_id) }
        .then { |file| Utils.resize_image(file) }

    emojis = message.text.split(' ')[1]
    add_sticker_to_set(bot, resized_image, emojis)

    send_feedback(bot, message)
  end

  def self.handle?(message)
    /^-fasdeia- .+$/i =~ message.text &&
    (message.reply_to_message&.photo&.any? || message.reply_to_message&.sticker)
  end

  private

  def self.get_file_id(message)
    return message.reply_to_message.photo.max_by { |f| f.file_size }.file_id if message.reply_to_message&.photo&.any?
    message.reply_to_message.sticker.file_id if message.reply_to_message&.sticker
  end

  def self.add_sticker_to_set(bot, resized_image, emojis)
    bot.api.add_sticker_to_set(
      user_id: Config::BOT_OWNER_ID,
      name: Config::BOT_NAME,
      png_sticker: Faraday::UploadIO.new(resized_image.path, 'image/png'),
      emojis: emojis
    )
  end

  def self.send_feedback(bot, message)
    bot.api.send_message(
      chat_id: message.chat.id,
      text: 'Sticker autárquico adicionado com sucesso.'
    )
  end
end
