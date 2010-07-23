# desc "Explaining what the task does"
# task :timber do
#   # Task goes here
# end

namespace :timber do
  desc 'Combine production logs from separate machines.'
  task :combine do
    logs = Dir.glob(ENV['LOGS'] || '')
    if logs.empty?
      puts "ERROR: No logs!"
      puts "Run like: rake timber:combine LOGS=production-*.log"
      exit
    end
    
    require File.dirname(__FILE__) + '/../lib/timber'
    Timber.combine(logs.sort)
  end
end
