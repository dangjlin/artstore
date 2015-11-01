# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron


 
#   set :output, "log/cron_log.log"
  set :output, { error: 'log/cron_error.log' }
  
  every 1.day, :at => '03:00 pm' do 
      rake "FEMG:get_FEMG_data"
  end
  
  every 1.day, :at => '01:00 pm' do
      rake "FEMG:get_quote_data"
  end

# after alter this file , please use "whenever -w " to write to crontab file


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
