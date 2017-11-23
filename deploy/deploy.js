var gith = require('gith').create(9001);
var execFile = require('child_process').execFile;

gith({
  repo: 'fasd-club/fasd-bot'
}).on( 'all', function( payload ) {
  console.log('hook received');
  if( payload.branch === 'master' )
  {
    execFile(`./deploy.sh`, function(error, stdout, stderr) {
      console.log('exec complete');
    });
  }
});
