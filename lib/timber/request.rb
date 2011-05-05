require 'time'

module Timber
  class Request
    attr_reader :lines

    PATTERNS = {} # filled via plugins

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
  end
end
