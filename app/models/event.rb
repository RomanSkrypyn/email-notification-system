# frozen_string_literal: true

class Event < ApplicationRecord
  include AASM

  belongs_to :user

  before_create :set_scheduled_date

  validates :subject, presence: true
  validates :body, presence: true
  validates :event_type, presence: true
  validates :scheduled_date, presence: true,
                             if: ->(object) { object.event_type == 'single_occurrence_event' }
  validates :days, presence: true,
                   if: ->(object) { object.event_type == 'interval_event' }
  validates :time_interval, presence: true,
                            numericality: { greater_than_or_equal_to: 600, only_integer: true },
                            if: ->(object) { object.event_type == 'interval_event' }

  scope :interval_events, -> { where('event_type = ?', 'interval_event') }
  scope :single_occurrence_events, -> { where('event_type = ?', 'single_occurrence_event') }
  scope :scheduled, -> { where('aasm_state = ?', 'scheduled') }
  scope :not_finished, -> { where.not('aasm_state = ?', 'finished') }

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

  def set_scheduled_date
    self.scheduled_date = DateTime.now if event_type == 'interval_event'
  end

  def self.match_to_day(day)
    all.select do |event|
      event.days.include? day.downcase
    end
  end

  def interval_event?
    event_type == 'interval_event'
  end

  def single_occurrence_event?
    event_type == 'single_occurrence_event'
  end

  def update_time
    update(scheduled_date: scheduled_date + time_interval.to_i)
  end

  def send_notification_mail
    EventMailer.schedule_event(self).deliver_now
  end
end
