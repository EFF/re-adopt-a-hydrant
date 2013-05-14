basePath = '';
urlRoot = '/test/';
proxies = {
  '/': 'http://localhost:5000/'
}
files = [
  ANGULAR_SCENARIO,
  ANGULAR_SCENARIO_ADAPTER,
  './tests/e2e/*.js'
];
exclude = [
  
];
reporters = ['progress'];
port = 9876;
runnerPort = 9100;
colors = true;
logLevel = LOG_INFO;
autoWatch = true;
browsers = ['Chrome', 'Firefox'];
captureTimeout = 60000;
singleRun = false;