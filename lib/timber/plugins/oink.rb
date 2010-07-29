module Timber
  module Plugins
    module Oink
      # Oink Plugin
      attr_reader :memory, :pid
      def memory
        @_memory ||= @memory ? @memory.to_i : nil
      end
      def ar_count
        @_ar_count ||= @ar_count ? @ar_count.to_i : nil
      end
    end
  end
  
  Request.class_eval {include Plugins::Oink}
  Request::PATTERNS[/Memory usage: (\d+) \| PID: (\d+)/] = [:memory, :pid]
  Request::PATTERNS[/Instantiation Breakdown: Total: (\d+)/] = [:ar_count]
end
