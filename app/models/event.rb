# frozen_string_literal: true

class Event < ApplicationRecord
  include AASM

  enum event_type: [:interval_event, :single_occurrence_event]

  belongs_to :user

  before_create :set_scheduled_date

  validates :subject, presence: true
  validates :body, presence: true
  validates :event_type, presence: true,
                         inclusion: { in: Event.event_types.keys }
  validates :scheduled_date_at, presence: true,
                             if: ->(object) { object.single_occurrence_event? }
  validates :days, presence: true,
                   if: ->(object) { object.interval_event? }
  validates :time_interval, presence: true,
                            numericality: { greater_than_or_equal_to: 600, only_integer: true },
                            if: ->(object) { object.interval_event? }

  scope :scheduled, -> { where(aasm_state: 'scheduled') }
  scope :not_finished, -> { where.not(aasm_state: 'finished') }

  aasm do
    state :scheduled, initial: true
    state :working
    state :finished

    event :run, before: :send_notification_mail, after: :update_time do
      transitions from: [:scheduled, :working], to: :working
    end

    event :finish, before: :send_notification_mail do
      transitions from: :scheduled, to: :finished
    end
  end

  def self.prepared_single_events
    scheduled.single_occurrence_event
      .where('scheduled_date_at <= ?', ::DateTime.now)
  end

  def self.prepared_interval_events
    find(Event.not_finished.interval_event
             .where('scheduled_date_at <= ?', ::DateTime.now)
             .match_to_day(Date.today.strftime('%A')))
  end

  def self.match_to_day(day)
    pluck(:id, :days).each_with_object([]) do |event, arr|
      arr << event[0] if event[1].include? day.downcase
    end
  end

  def set_scheduled_date
    self.scheduled_date_at = DateTime.now if self.interval_event?
  end

  def update_time
    update(scheduled_date_at: scheduled_date_at + time_interval.to_i.seconds)
  end

  def send_notification_mail
    EventMailer.schedule_event(self).deliver_now
  end
end
