class AttendancesController < ApplicationController
  before_action :check_if_signed_in, except: [:index, :show]
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]

  # GET /attendances
  # GET /attendances.json
  def index
    #@attendances = Attendance.all
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  # POST /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)
    @attendance.user = current_user if current_user
    respond_to do |format|
      if @attendance.save
        current_user.attendances << @attendance
        format.html { redirect_to @attendance.event, notice: "You registered to #{@attendance.event.name}." }
        format.json { render :show, status: :created, location: @attendance.event }
      else
        format.html { render :new }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    event = @attendance.event
    if event.admins.include?current_user and event.admins.count==1
      redirect_to :back, notice: "Destroy event or make someone else admin first"
    else
      @attendance.destroy
      respond_to do |format|
        format.html { redirect_to current_user, notice: "You are no longer registered to #{event.name}." }
        format.json { head :no_content }
      end
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.require(:attendance).permit(:event_id, :user_id)
    end
    
    def check_if_signed_in
      if current_user.nil?
        session[:proceed_path] = event_path
        redirect_to signin_path, notice: 'Sign in to proceed'
      end
    end
end
