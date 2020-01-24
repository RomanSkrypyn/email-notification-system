# frozen_string_literal: true

class EventMailer < ApplicationMailer
  def schedule_event(event)
    user = event.user

    mail(to: user.email, subject: event.subject, body: event.body)
  end
end
