class MessagesController < ApplicationController
  before_action :check_if_signed_in, except: [:index, :show]
  #before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_message, only: [:edit, :update, :destroy]
  before_action :prevent_access, only: [:index, :show]

  # GET /messages
  # GET /messages.json
  def index
    #@messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.timestamp = Time.current if @message.timestamp.nil?
    @message.user = current_user if @message.user.nil?
    respond_to do |format|
      if @message.save
        format.html { redirect_to @message.event }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    if @message.user == current_user or @message.event.admins.include?current_user
      event = @message.event
      @message.destroy
      respond_to do |format|
        format.html { redirect_to event, notice: 'Message was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to :back, notice: 'You can not destroy that message'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:user_id, :event_id, :msg, :timestamp)
    end
    
    def check_if_signed_in
      if current_user.nil?
        #session[:proceed_path] = event_path
        redirect_to signin_path, notice: 'Sign in to proceed'
      end
    end
    
    def prevent_access
      redirect_to :root, notice: 'Operation not permitted'
    end
end
