$: << File.dirname(__FILE__)
require 'timber/log'
require 'timber/request'
require 'timber/plugins/oink'
require 'timber/plugins/rails-3.0'

module Timber
  # combines the given logs into a single file, while maintaining chronological order.
  #
  # note that sometimes the source logs aren't in strict chronological order, and that
  # inexactness will carry through to the combined file.
  def self.combine(log_paths)
    logs = log_paths.map{|log| Timber::Log.new(log) }

    # prime each log
    logs.each{ |log| log.rewind; log.shift }

    # open the combined log
    File.open("#{logs.first.name}-combined.log", 'w') do |out|
      # take the log with the oldest entry
      while next_log = logs.sort_by{|l| l.current.time}.first
        # stuff the request into the output, and shift that log
        out << next_log.current.lines << "\n\n"
        next_log.shift
        # if this log is now empty, take it out of rotation
        logs = logs - [next_log] if next_log.current.nil?
      end
    end
  end
end
