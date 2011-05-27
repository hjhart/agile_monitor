desc "Starts a queue that will fetch bus data as well as build data"
task :fetcher => :environment do
  puts "Environment loaded. Tasks will start soon..."
  Scheduler.new
end