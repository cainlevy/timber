module Timber
  module Plugins
    module Rails23
      attr_reader :controller, :method, :time
      attr_reader :benchmark, :url

      def action
        @action ||= controller + "#" + method
      end

      def time
        @_time ||= Time.parse(@time)
      end

      def benchmark
        @_benchmark ||= @benchmark ? @benchmark.to_i : nil
      end
    end
  end

  Log.marker = /^Processing/

  Request.class_eval {include Plugins::Rails23}
  Request::PATTERNS.merge!(
    /Processing ([^#]+)Controller#([^ ]+).* at (\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d)\)/ => [:controller, :method, :time],
    /Completed in (\d+)ms .* \[(.*)+\]/ => [:benchmark, :url]
  )
end
