module Timber
  module Plugins
    module Oink
      # Oink Plugin
      attr_reader :memory, :pid
      def memory
        @_memory ||= @memory ? @memory.to_i : nil
      end
    end
  end
  
  Request.class_eval {include Plugins::Oink}
  Request::PATTERNS[/Memory usage: (\d+) \| PID: (\d+)/] = [:memory, :pid]
end
