# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
env :PATH, ENV['PATH']
job_type :sidekiq,  "cd :path && RAILS_ENV=:environment bundle exec sidekiq -r ./sidekiq.yml "
# job_type :sidekiq, "cd :path && BUNDLE_PATH=/bundle /usr/local/bin/bundle exec sidekiq-client :task :output"
set :output, "#{path}/log/sidekiq.log"
set :environment, :production
# set :environment, :development

every 3.hours do
  sidekiq 'push HardWorker'
end

every 15.minutes do
  sidekiq 'push CpWorker'
end

every :hour do
  sidekiq 'push GhotimeWorker'
end

every :hour do
  sidekiq 'push HealthpWorker'
end

every :hour do
  sidekiq 'push HealthbWorker'
end
# Sidekiq.configure_server do |config|
#   config.on(:startup) do
#     Sidekiq.schedule = YAML.load_file(File.expand_path("../sidekiq.yml", __FILE__))
#     Sidekiq::Scheduler.enabled = true
#     Sidekiq::Scheduler.reload_schedule!
#   end
# end
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
