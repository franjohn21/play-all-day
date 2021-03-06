class EventsController < ApplicationController
  before_filter :authorize

  def index
    @events = []
    Event.all.map do |event|
      num_going = UserEvent.where(:event_id => event.id, :attending => true ).count
      @events << {:event => event, :num_going => num_going}
    end

  end

  def rsvp
    exists = UserEvent.find_by(event_id: params[:event_id], user_id: @current_user.id)
    if exists
      exists.attending = !exists.attending
      exists.save!
    else
      UserEvent.create(event_id: params[:event_id], user_id: @current_user.id, attending: true)
    end
    render :json => 'success'
  end


  def show
    @event = Event.find(params[:id])
    @users = []
    @event.user_events.where(:attending => true).each do |userevent|
      @users << User.find(userevent.user_id)
    end

  end


end


