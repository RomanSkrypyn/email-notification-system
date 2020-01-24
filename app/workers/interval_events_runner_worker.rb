# frozen_string_literal: true

class IntervalEventsRunnerWorker
  include Sidekiq::Worker

  def perform
    Event.where(id: Event.not_finished.interval_events
                         .where('scheduled_date <= ?', ::DateTime.now)
                         .match_to_day(Date.today.strftime('%A')))
      .find_each(&:run!)
  end
end
