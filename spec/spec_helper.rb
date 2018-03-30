# frozen_string_literal: true

# debugger
require 'pry-byebug'
# binding.pry

require 'simplecov'
SimpleCov.start do
  add_filter(/_spec.rb/)
end

# load code
require './lib/selenium_page.rb'

RSpec.configure do |config|
  # randomness
  config.order = :random

  # verify the mocked class
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
    mocks.verify_partial_doubles = true
  end
end
