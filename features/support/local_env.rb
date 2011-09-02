$LOAD_PATH << File.expand_path(File.basename(__FILE__) + "/../../spec/factories")
require 'factory_girl'
Dir["#{File.dirname(__FILE__)}/../../spec/factories/*.rb"].each {|f| require f}

require 'email_spec'
require 'email_spec/cucumber'
