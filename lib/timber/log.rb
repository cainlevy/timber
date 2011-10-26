module Timber
  class Log
    class << self
      attr_accessor :marker
    end

    attr_reader :current, :name

    def initialize(f)
      @file = f.is_a?(String) ? File.open(f, 'r') : f
      @line = nil
      @name = File.basename(@file.path).sub(/\..*$/, '')

      # discard any comments or junk at the top of the file
      until @line.to_s.match(self.class.marker)
        @line = @file.gets
      end
    end

    def shift
      @current = Request.new
      # leftover line from parsing the previous request
      @current << @line if @line
      # take all lines until the next Processing line, which stays for the next shift
      while @line = @file.gets
        if @line.match(self.class.marker) and not @current.lines.empty?
          return current
        elsif @line != "\n"
          @current << @line
        end
      end
      @current = nil if current.lines.empty?
      @current
    end

    def rewind
      @current = nil
      @file.rewind
    end
  end
end
