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
    when /^-fasd- (sexta|sextas|sextou)/i
      'https://i.redd.it/gnzgfzhqxy301.jpg'
    when /^-fasd- healthcheck$/i
      'Tô aqui carniça!'
    when /^-fasd- (terça|terças)$/i
      """
      Ode às terças-feiras

Ó terça, não sois a segunda,
Que de tédio abunda
Porém sois sua prima,
Que em sua jornada nos torna saudosistas,
Fazendo-nos lembrar de felizes momentos de outrora,
Onde cada indivíduo felicidade emana,
No também conhecido 'final de semana'
      """
    when /^-fasd- (quarta|quartas)$/i
      """
      Ode às quartas-feiras

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
