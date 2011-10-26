require 'test/test_helper'

class TimberTest < ActiveSupport::TestCase
  test "should name a log file" do
    @log = Timber::Log.new('test/sample-3-0-10.log')
    assert_equal 'sample-3-0-10', @log.name
  end

  test "should find all requests in log file" do
    @log = Timber::Log.new('test/sample-3-0-10.log')
    i = 0
    i += 1 while request = @log.shift
    assert_equal 3, i
  end

  test "should represent a request in a log file" do
    @log = Timber::Log.new('test/sample-3-0-10.log')
    @request = @log.shift
    assert_equal 'Foos', @request.controller
    assert_equal 'show', @request.method
    assert_equal Time.parse('Tue Oct 25 17:03:41 -0400 2011'), @request.time
    assert_equal 72, @request.benchmark
    assert_equal '/foos/1', @request.url
    assert_equal 6, @request.lines.count
    assert_equal({'id' => '1'}, @request.params)
  end

  test "should extract oink data" do
    @log = Timber::Log.new('test/sample-3-0-10.log')
    @request = @log.shift
    assert_equal 258416, @request.memory
    assert_equal "5290", @request.pid
  end
end
