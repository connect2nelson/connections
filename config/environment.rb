# Load models from lib
Dir['./lib/models/*.rb'].each { |f| require(f) }

# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Connections::Application.initialize!

# Using Rails Logger
Rails.logger = Logger.new(STDOUT)
