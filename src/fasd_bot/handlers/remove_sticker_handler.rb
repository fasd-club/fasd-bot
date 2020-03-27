module RemoveStickerHandler
  class << self
    def handle(bot, message)
      sticker_id = get_last_sticker_id(bot)
      delete_sticker(bot, sticker_id)
      send_feedback(bot, message)
    end

    def handle?(message)
      /^-desfasdeia-(\s*)?$/i =~ message.text
    end

    private

    def get_last_sticker_id(bot)
      sticket_set = bot.api.get_sticker_set(name: Config::BOT_NAME)['result']
      sticket_set['stickers'].last['file_unique_id']
    end

    def delete_sticker(bot, id)
      bot.api.delete_sticker_from_set(sticker: id)
    end

    def send_feedback(bot, message)
      messages = [
        'O sticker foi enviado pra Paul.',
        'O sticker foi enviado pra Jaburuna.',
        'O sticker foi pras pracinhas de Jardim da Penha, nunca mais será visto.',
      ]
      bot.api.send_message(
        chat_id: message.chat.id,
        text: messages.sample
      )
    end
  end
end
