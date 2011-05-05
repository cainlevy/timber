require 'rubygems'
require 'test/unit'
gem 'rails', '2.3.11'
require 'active_support'
require 'active_support/test_case'

PLUGIN_ROOT = File.dirname(__FILE__) + '/../'
ActiveSupport::Dependencies.autoload_paths << File.join(PLUGIN_ROOT, 'lib')
