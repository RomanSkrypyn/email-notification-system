# frozen_string_literal: true

class IntervalEventsRunnerWorker
  include Sidekiq::Worker

  def perform
    Event.prepared_interval_events.map(&:run!)
  end
end
