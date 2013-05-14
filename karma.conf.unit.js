basePath = '';
files = [
  MOCHA,
  MOCHA_ADAPTER,
  {pattern: 'tests/unit/no_deps_bullshit.js', included: true, watched: false, served: true},
  {pattern: 'vendors/closure-library/closure/goog/base.js', included: true, watched: false, served: true},
  {pattern: 'vendors/closure-library/closure/**/*.js', included: false, watched: false, served: true},
  {pattern: 'tests/unit/deps.js', include: true, watched: true, served: true},
  {pattern: 'public/javascripts/**/*.js', include: false, watched: true, served: true},
  {pattern: 'tests/unit/*.test.*'},
  {pattern: 'node_modules/chai/chai.js'}
];

preprocessors = {
  'tests/**/*.coffee': 'coffee'
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
