function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    baseUrl: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
        config.userEmail = 'karate@karate.com'
        config.userName = 'karatehugo'
        config.userPass = 'karate'
  } else if (env == 'qa') {
        config.userEmail = 'karateqa@karate.com'
        config.userName = 'karatehugo'
        config.userPass = 'karate'
  }

/*
*  The authorization token is set at a global level, so that it's not required to create a new token for
*  every authenticated request.
*  If some of the request needed to be sent w/o authentication, then the *helpers/CreateToken.feature* file
*  would have to be invoked in the background section in every .feature file that were needed.
*/
  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: "Token " + accessToken})

  return config;
}