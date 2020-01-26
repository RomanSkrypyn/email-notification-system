# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe IntervalEventsRunnerWorker, type: :worker do

  describe 'IntervalEventsRunnerWorker perform' do
    before do
      event
      described_class.perform_async
      Sidekiq::Worker.drain_all
    end

    it 'should change event state to working' do
      expect(Event.find(event.id)).to have_state(:working)
    end
  end


  private

  def user
    @user ||= FactoryBot.create(:user)
  end

  def event
    @event ||= FactoryBot.create(:event, event_type: 'interval_event', days: [Date.today.strftime('%A').downcase], time_interval: 600, user: user)
  end
end
