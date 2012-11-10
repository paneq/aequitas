require 'minitest/autorun'
require 'minitest/unit'

require 'aequitas'

#$LOAD_PATH << File.expand_path('../../lib', __FILE__)

Dir[File.expand_path('../{support,shared}/**/*.rb', __FILE__)].each { |f| require(f) }
