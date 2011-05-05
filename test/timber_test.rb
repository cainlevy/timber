require 'test/test_helper'

class TimberTest < ActiveSupport::TestCase
  test "should name a log file" do
    @log = Timber::Log.new('test/sample-2-3-11.log')
    assert_equal 'sample-2-3-11', @log.name
  end

  test "should find all requests in log file" do
    @log = Timber::Log.new('test/sample-2-3-11.log')
    i = 0
    i += 1 while request = @log.shift
    assert_equal 4, i
  end

  test "should represent a request in a log file" do
    @log = Timber::Log.new('test/sample-2-3-11.log')
    @request = @log.shift
    assert_equal 'Foos', @request.controller
    assert_equal 'redirect', @request.method
    assert_equal Time.parse('Thu May 05 09:42:48 -0700 2011'), @request.time
    assert_equal 142, @request.benchmark
    assert_equal 'http://www.example.com/foos/redirect', @request.url
    assert_equal 6, @request.lines.count
  end

  test "should extract oink data" do
    @log = Timber::Log.new('test/sample-2-3-11.log')
    @request = @log.shift
    assert_equal 283212, @request.memory
    assert_equal "8000", @request.pid
  end
end
