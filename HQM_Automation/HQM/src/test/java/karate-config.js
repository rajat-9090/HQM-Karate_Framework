function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'test';
  }
  var config = {
    env: env,
    //Setting up the Driver to Run
    ChromeDriver: {
          type: 'chromedriver',
          executable: 'C:\\Users\\Admin\\OneDrive - health-chain.io\\Desktop\\Extra_Applications\\All Drivers\\chromedriver.exe'
        },
    URL: 'https://hqm.health-chain.io'
  };
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}