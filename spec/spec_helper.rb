require 'bundler/setup'

RSpec.configure do |config|
  config.mock_with :rspec
  config.color_enabled = true
end

require 'amy_admin'
