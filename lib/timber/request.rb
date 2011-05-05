require 'time'

module Timber
  class Request
    attr_reader :lines
    attr_reader :controller, :method, :time
    attr_reader :benchmark, :url
    
    PATTERNS = {
      /Processing ([^#]+)Controller#([^ ]+).* at (\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d)\)/ => [:controller, :method, :time],
      /Completed in (\d+)ms .* \[(.*)+\]/ => [:benchmark, :url]
    }

    def initialize
      @lines = []
    end
    
    def <<(line)
      PATTERNS.each do |pattern, vars|
        if md = line.match(pattern)
          vars.each_with_index do |v, i|
            instance_variable_set("@#{v}", md[i + 1])
          end
        end
      end
      @lines << line
      self
    end
    
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
