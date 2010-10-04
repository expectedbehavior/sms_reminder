desc "Should be run once per day to notify subscribers. This task is called by the Heroku cron add-on."
task :cron => :environment do
 if false # Time.now.hour == 12 # run at noon
   Reminder.notify_all_subscribers
 end
end
