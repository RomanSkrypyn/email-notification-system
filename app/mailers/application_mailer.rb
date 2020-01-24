# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV['GMAIL_USER']
  layout 'mailer'
end
