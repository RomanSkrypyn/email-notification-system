# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe IntervalEventsRunnerWorker, type: :worker do
  let(:scheduled_job) { described_class.perform_async }

  it 'job in correct queue' do
    described_class.perform_async
    assert_equal 'default', described_class.queue
  end

  it 'goes into the jobs array for testing environment' do
    expect do
      described_class.perform_async
    end.to change(described_class.jobs, :size).by(1)
    described_class.new.perform
  end
end
