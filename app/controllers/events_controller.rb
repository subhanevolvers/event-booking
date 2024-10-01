# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @events = Event.all
  end

  def new
    @event = current_user.events.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      flash[:notice] = 'Event created successfully!'
      redirect_to event_path(@event)
    else
      flash[:alert] = 'Error creating event!'
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    # @event is already set by before_action :set_event and authorized by authorize_user!
  end

  def update
    if @event.update(event_params)
      flash[:notice] = 'Event updated successfully!'
      redirect_to event_path(@event)
    else
      flash[:alert] = 'Error updating event!'
      render :edit
    end
  end

  def destroy
    @event.destroy
    flash[:notice] = 'Event deleted successfully!'
    redirect_to my_events_path
  end

  def my_events
    @events = current_user.events
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_user!
    return if @event.user == current_user

    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to events_path
  end

  def event_params
    params.require(:event).permit(:name, :description, :location, :available_tickets, :schedule_at)
  end
end
