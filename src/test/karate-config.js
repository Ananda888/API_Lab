function fn() {
    var env = karate.env
    karate.log('Environment is: ', env);
  var config = {
    env: env,
    myVarName: 'someValue',
    baseUrl: 'http://localhost:8500',
    testDataFile: 'classpath:resources/data/carRegos.yml',
  };


  if (env == 'sit') {
    config.testDataFile = 'classpath:resources/data/carRegos.yml'

  } else if (env == 'qa') {
    config.testDataFile = 'classpath:resources/data/carRegos.csv'
  } else {

  }
  return config;
}