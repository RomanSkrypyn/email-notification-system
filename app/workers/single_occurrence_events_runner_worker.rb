# frozen_string_literal: true

class SingleOccurrenceEventsRunnerWorker
  include Sidekiq::Worker

  def perform
    Event.prepared_single_events.find_each(&:finish!)
  end
end
