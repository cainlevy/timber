module Timber
  module Plugins
    module Rails30
      attr_reader :http_method, :url, :ip, :time
      attr_reader :controller, :method, :format
      attr_reader :params
      attr_reader :status, :benchmark

      def action
        @action ||= controller + "#" + method
      end

      def time
        @_time ||= Time.parse(@time)
      end

      def params
        @_params ||= eval(@params)
      end

      def benchmark
        @_benchmark ||= @benchmark ? @benchmark.to_i : nil
      end
    end
  end

  Log.marker = /^Started/

  Request.class_eval {include Plugins::Rails30}
  Request::PATTERNS.merge!(
    /Started ([A-Z]+) "(.+?)" for ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+) at (.*)/ => [:http_method, :url, :ip, :time],
    /\s\sProcessing by ([^#]+)Controller#([^ ]+).* as (.*)/ => [:controller, :method, :format],
    /\s\sParameters: (\{.*\})/ => [:params],
    /Completed ([0-9]{3}.*) in (\d+)ms/ => [:status, :benchmark]
  )
end
