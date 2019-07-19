require 'fasd_bot/config'

module GenericReplyHandler
  def self.handle(bot, message)
    reply_message = get_reply_message(message)

    return unless reply_message

    bot.api.send_message(
      chat_id: message.chat.id,
      text: reply_message
    )
  end

  def self.handle?(message)
    /.*/i =~ message.text
  end

  private

  def self.get_reply_message(message)
    case message.text
    when /^-fasd- healthcheck$/i
      'Tô aqui carniça!'
    when /^-fasd- (quarta|quartas)$/i
      """
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
  end
end
end
