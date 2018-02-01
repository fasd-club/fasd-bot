const TelegramBot = require('node-telegram-bot-api');
const WundergroundApi = require('wunderground-api-client');

const bot = new TelegramBot(process.env.TELEGRAM_TOKEN, {polling: true});

var wunderContext = new WundergroundApi.WunderApi(process.env.WUNDERGROUND_TOKEN, {lang: 'EN'}, 'hourly', 'conditions');

bot.onText(/\@weather$/, (msg, match) => {
  wunderContext.query('zmw:00000.1.02485')
    .then(function (result) {
      const chatId = msg.chat.id;

      var current_observation = result.current_observation;

      var output = `Current temperature on <b>Stockholm, Sweden</b>\n`;
      output += `<b>${current_observation.temp_c} °C</b> (Feels like ${current_observation.feelslike_c} °C)\n\n`;

      for (data of result.hourly_forecast.slice(0,7)) {
        var hour = data.FCTTIME.hour_padded + ':00';
        var emoji = "\u{231A}";
        output += `${emoji} ${hour} | Temp: ${data.temp.metric} °C | Precip: ${data.pop}%\n`
      }

      bot.sendMessage(chatId, output, { parse_mode: 'html'});
    }).fail(function (err) {console.dir(err)}).done();

});

const simpleTextMatch = (regex, output) => {
  bot.onText(regex, (msg) => {
    bot.sendMessage(msg.chat.id, output, { parse_mode: 'markdown'});
  });
};

simpleTextMatch(/janete/i, 'https://preview.ibb.co/k9niAR/jn.jpg');
simpleTextMatch(/galinha/i, 'galinha? https://i.imgur.com/R77BVs1.png');

simpleTextMatch(/heloisa/i, 'https://goo.gl/HRYbzN');

bot.onText(/comida/i, (msg) => bot.sendDocument(msg.chat.id, './sauce/mrtz-hungry.gif', { caption: 'Opa, comida?? Onde?' }));
bot.onText(/feliz/i, (msg) => bot.sendDocument(msg.chat.id, './sauce/mrtz-happy.gif'));
simpleTextMatch(/(mirtes|cachorr(o|a)|🐶|🐩)/i, 'https://i.imgur.com/04sinBI.jpg');

simpleTextMatch(/(🐮|va(ca|quinha))/i, 'https://i.imgur.com/EmusbT3.png');
simpleTextMatch(/valk(i|í)ria/i, 'http://braaiboy.co.za/wp-content/uploads/2015/09/mad-cow.png');
