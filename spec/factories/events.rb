FactoryBot.define do
  factory :event do
    subject { 'Hello' }
    body { 'Body' }
    event_type { 'single_occurrence_event' }
    scheduled_date_at { Faker::Date.in_date_period(month: 1) }
    user
  end
end
