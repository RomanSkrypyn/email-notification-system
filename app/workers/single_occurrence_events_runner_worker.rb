# frozen_string_literal: true

class SingleOccurrenceEventsRunnerWorker
  include Sidekiq::Worker

  def perform
    Event.scheduled
      .single_occurrence_events
      .where('scheduled_date <= ?', ::DateTime.now)
      .find_each(&:finish!)
  end
end
