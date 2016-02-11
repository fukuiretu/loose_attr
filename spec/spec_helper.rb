Bundler.require
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require "codeclimate-test-reporter"
require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[SimpleCov::Formatter::HTMLFormatter,CodeClimate::TestReporter::Formatter]

dir = File.join("..", "coverage")
SimpleCov.coverage_dir(dir)
SimpleCov.start CodeClimate::TestReporter.configuration.profile
