# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
env :PATH, ENV['PATH']
job_type :sidekiq,  "cd :path && RAILS_ENV=:environment bundle exec sidekiq-client -r
 false :task :output"
# job_type :sidekiq, "cd :path && BUNDLE_PATH=/bundle /usr/local/bin/bundle exec sidekiq-client :task :output"
set :output, "#{path}/log/sidekiq.log"
set :environment, :production
# set :environment, :development
every 3.minutes do
  sidekiq 'push HardWorker'
end
# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
