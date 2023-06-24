# frozen_string_literal: true

require 'stosp'
require 'webmock/rspec'
require 'json'
require 'simplecov'

SimpleCov.start

RSpec.configure do |config|
  config.before :all do
    WebMock.enable!
  end
end
