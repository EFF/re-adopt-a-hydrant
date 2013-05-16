basePath = '';
files = [
  MOCHA,
  MOCHA_ADAPTER,
  {pattern: '../../vendors/closure-library/closure/goog/base.js', included: true, watched: false, served: true},
  {pattern: '../../vendors/closure-library/closure/**/*.js', included: false, watched: false, served: true},
  {pattern: '../frontend-unit/deps.js', include: true, watched: true, served: true},
  {pattern: '../../public/javascripts/**/*.js', include: false, watched: true, served: true},
  {pattern: '../frontend-unit/*.test.*'},
  {pattern: '../../node_modules/chai/chai.js'}
];

preprocessors = {
  '../**/*.coffee': 'coffee'
};
reporters = ['progress'];
port = 9876;
runnerPort = 9100;
colors = true;
logLevel = LOG_INFO;
autoWatch = true;
browsers = ['Chrome', 'Firefox'];
captureTimeout = 60000;
singleRun = false;
