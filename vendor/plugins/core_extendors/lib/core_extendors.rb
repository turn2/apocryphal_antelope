# CoreExtendors
module CoreExtendors
  ALPHANUM = ["a".."z", "A".."Z", "0".."9"].collect{|r| r.to_a}.flatten
end

require 'core_extendors/string'
require 'core_extendors/version'

String.class_eval do
  extend CoreExtendors::String::Extendors
  include CoreExtendors::String::Includors
end
