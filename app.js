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

bot.onText(/janete/i, (msg, match) => {
  const chatId = msg.chat.id;

  var output = 'https://goo.gl/hdVn48';

  bot.sendMessage(chatId, output, { parse_mode: 'markdown'});
});

bot.onText(/galinha/i, (msg, match) => {
  const chatId = msg.chat.id;

  var output = 'galinha? https://i.imgur.com/R77BVs1.png';

  bot.sendMessage(chatId, output, { parse_mode: 'markdown'});
});
