# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sprzedaj::Application.initialize!


Paperclip.options[:command_path]="/usr/bin"
ActionMailer::Base.delivery_method= :smtp

