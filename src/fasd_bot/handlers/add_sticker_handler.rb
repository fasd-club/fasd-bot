require 'fasd_bot/config'
require 'fasd_bot/utils'

module AddStickerHandler
  def self.handle(bot, message)
    file_id = get_file_id(message)
    file = bot.api.get_file(file_id: file_id)
    resized_image = Utils.resize_image(file)

    bot.api.add_sticker_to_set(
      user_id: Config::BOT_OWNER_ID,
      name: Config::BOT_NAME,
      png_sticker: Faraday::UploadIO.new(resized_image.path, 'image/png'),
      emojis: message.text.split(' ')[1]
    )

    bot.api.send_message(
      chat_id: message.chat.id,
      text: 'Sticker autárquico adicionado com sucesso.'
    )
  end

  def self.handle?(message)
    /^-fasdeia- .+$/i =~ message.text && (message.reply_to_message&.photo&.any? || message.reply_to_message&.sticker)
  end

  private

  def self.get_file_id(message)
    message.reply_to_message&.photo || message.reply_to_message&.sticker
  end
end
