require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  before do
    sign_in user
    events
  end

  describe "GET #index" do
    before { get :index }

    it 'should has status :success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all events' do
      expect(assigns(:events).count).to eq(Event.count)
    end

    it 'render index template' do
      expect(response).to render_template(:index)
    end
  end

  describe "POST #create" do
    subject { post :create, params: params }

    context 'with valid params' do

      let(:params) do
        { event: { subject: 'Hello', body: 'Some text', event_type: 'single_occurrence_event', scheduled_date_at: DateTime.now } }
      end

      it 'should create new event' do
        expect{ subject }.to change(Event, :count).by(1)
      end
    end

    context 'with invalid params' do
      before { subject }

      let(:params) do
        { event: { subject: 'Hello', body: 'Some text', event_type: 'single_occurrence_event', scheduled_date_at: nil } }
      end

      it 'should raise error' do
        expect(assigns(:event).errors).to_not be_empty
      end
    end
  end

  private

  def user
    @user ||= FactoryBot.create(:user)
  end

  def events
    @events ||= [
      FactoryBot.create(:event, event_type: 'single_occurrence_event', user: user),
      FactoryBot.create(:event, event_type: 'interval_event', days: ['friday'], time_interval: 600, user: user)
    ].sort_by(&:id)
  end
end
