# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_resource, except: :index
  before_action :find_collection, only: :index

  def index; end

  def show; end

  def new; end

  def create
    @event.assign_attributes event_params

    if @event.save
      flash[:notice] = 'Successfully created'

      redirect_to events_path
    else
      flash.now[:alert] = @event.errors.full_messages.join('. ')

      render :new
    end
  end

  def edit; end

  def update
    if @event.update event_params
      flash[:notice] = 'Successfully updated'

      redirect_to events_path
    else
      flash.now[:alert] = @event.errors.full_messages.join('. ')

      render :edit
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = 'Successfully deleted'
    else
      flash[:alert] = @event.errors.full_messages.join('. ')
    end

    redirect_to events_path
  end

  private

  def find_collection
    @events = current_user.events
  end

  def find_resource
    @event = params[:id].present? ? Event.find(params[:id]) : current_user.events.new
  end

  def event_params
    params.require(:event).permit!
  end
end
