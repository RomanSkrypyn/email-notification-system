require "rails_helper"

RSpec.describe EventMailer, type: :mailer do
  describe 'schedule event' do
    before { deliver_mail }

    it 'renders the headers subject' do
      expect(ActionMailer::Base.deliveries.last.subject).to eq(event.subject)
    end

    it 'renders the headers to' do
      expect(ActionMailer::Base.deliveries.last.to).to eq([user.email])
    end

    it 'renders the body' do
      expect(ActionMailer::Base.deliveries.last.body.encoded).to match(event.body)
    end
  end

  private

  def deliver_mail
    EventMailer.schedule_event(event).deliver
  end

  def user
    @user ||= FactoryBot.create(:user)
  end

  def event
    FactoryBot.create(:event, event_type: 'single_occurrence_event', user: user)
  end
end
