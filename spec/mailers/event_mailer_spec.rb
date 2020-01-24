require "rails_helper"

RSpec.describe EventMailer, type: :mailer do
  describe 'schedule event' do
    let(:mail) { EventMailer.schedule_event event }

    it 'renders the headers' do
      expect(mail.subject).to eq(event.subject)
      expect(mail.to).to eq([user.email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(event.body)
    end
  end

  private

  def user
    @user ||= FactoryBot.create(:user)
  end

  def event
    FactoryBot.create(:event, event_type: 'single_occurrence_event', user: user)
  end
end
