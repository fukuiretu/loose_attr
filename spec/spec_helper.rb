Bundler.require
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

RSpec.configure do
end
