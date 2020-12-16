require 'telegram/bot'
require 'fasd_bot/config'
require 'fasd_bot/utils'

require 'fasd_bot/handlers/add_sticker_handler'
require 'fasd_bot/handlers/remove_sticker_handler'
require 'fasd_bot/handlers/generic_reply_handler'

# will be handled in the same order
HANDLERS = [
  AddStickerHandler,
  RemoveStickerHandler,
  GenericReplyHandler,
].freeze

puts "Telegram bot initialized!"
puts "Using [#{Config::STICKER_COLLECTION_NAME}] sticker collection"

Telegram::Bot::Client.run(Config::TELEGRAM_TOKEN, timeout: 60) do |bot|
  bot.listen do |message|
    next unless message.text

    HANDLERS.each do |handler|
      begin
        handler.handle(bot, message) if handler.handle?(message)
      rescue => e
        bot.api.send_message(
          chat_id: message.chat.id,
          text: "Que morte horrível soldado. #{e.message}."
        )
      end
    end
  end
end
