require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'init.rb')

Rspec.configure do |c|
  c.filter_run :focus => true
  c.run_all_when_everything_filtered = true
end

