require 'telegram/bot'
require './config'
require './handlers'

Telegram::Bot::Client.run(Config.TOKEN) do |bot|
  bot.listen do |message|
    message.text
    .then { |text| HANDLERS.detect { |k, v| k =~ text } }
    .then { |match| send(match[1], bot, message) if match }
  end
end
