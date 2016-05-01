class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :manage_password, :unset_password]
  before_action :check_if_signed_in
  before_action :check_if_event_admin, only: [:edit, :update, :destroy, :unset_password]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    if @event.attenders.include?current_user
      @can_be_shown = true
      @attendance = get_attendance
      @message = Message.new
      @message.event = @event
      @message.user = current_user
    else
      @can_be_shown = @event.password == session["pass_for_#{params[:id]}"] or @event.password.nil?
       session["pass_for_#{params[:id]}"] = nil if session["pass_for_#{params[:id]}"]
      @attendance = Attendance.new
      @attendance.event = @event
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.admins << current_user
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def manage_password    
  end
  
  def unset_password
    @event.password = nil
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event password deleted.' }
      else
        format.html { redirect_to @event, notice: 'Error deleting event password.' }
      end
    end
  end

  def read_password
    #raise
    session["pass_for_#{params[:id]}"] = params[:password]
    #raise
    redirect_to event_path(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find_by(id:params[:id])
      if @event.nil? 
        redirect_to :root, notice: 'No bonus'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :time, :place, :info, :password)
    end
    
    def get_attendance
      @event.attendances.find_by(user_id:current_user.id)
    end
    
    def check_if_signed_in
      if current_user.nil?
        session[:proceed_path] = event_path if @event
        redirect_to signin_path, notice: 'Sign in to proceed'
      end
    end
    
    def check_if_event_admin
      if current_user.nil? or not @event.admins.include?current_user
        redirect_to :back, notice: 'Operation not permitted'
      end  
    end
end
