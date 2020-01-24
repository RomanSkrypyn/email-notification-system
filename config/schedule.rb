# frozen_string_literal: true
set :output, "#{path}/log/cron.log"

every 5.minutes do
  runner '::IntervalEventsRunnerWorker.perform_async'
end

every 1.minute do
  runner '::SingleOccurrenceEventsRunnerWorker.perform_async'
end
