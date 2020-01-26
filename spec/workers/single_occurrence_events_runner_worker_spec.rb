# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe SingleOccurrenceEventsRunnerWorker, type: :worker do

  describe 'SingleOccurrenceEventsRunnerWorker perform' do
    before do
      event
      described_class.perform_async
      Sidekiq::Worker.drain_all
    end

    it 'should change event state to finished' do
      expect(Event.find(event.id)).to have_state(:finished)
    end
  end


  private

  def user
    @user ||= FactoryBot.create(:user)
  end

  def event
    @event ||= FactoryBot.create(:event, event_type: 'single_occurrence_event', scheduled_date_at: (Date.current - 1), user: user)
  end
end
