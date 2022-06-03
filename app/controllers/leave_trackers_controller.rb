class LeaveTrackersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_leavetracker, only: %i[ edit update destroy approve_reject ]
  # load_and_authorize_resource

  def index
    @leavetrackers = LeaveTracker.all
     # binding.pry
  end

  def fetch_leaves
    if current_user.emp_admin? 
      leavetrackers = LeaveTracker.all.order(created_at: :desc)
    else 
      leavetrackers = current_user.leave_trackers.order(created_at: :desc)
    end 
    search_string = []
    ## Check if Search Keyword is Present & Write it's Query
    if params.has_key?('search') && params[:search].has_key?('value') && params[:search][:value].present?
      search_columns.each do |term|
        search_string << "#{term} ILIKE :search"
      end
      leavetrackers = leavetrackers.where(search_string.join(' OR '), search: "%#{params[:search][:value]}%")
    end

    leavetrackers = leavetrackers.order("#{sort_column} #{datatable_sort_direction}") unless sort_column.nil?
    leavetrackers = leavetrackers.page(datatable_page).per(datatable_per_page)  
    render json: {
      leavetrackers:leavetrackers.as_json,
      draw: params['draw'].to_i,
      recordsTotal:leavetrackers.count,
      recordsFiltered:leavetrackers.total_count,
    }
  end

  # Display Timesheet Data
  def show
  end

  # GET /leavtrackers/new
  def new
    @leavetracker = LeaveTracker.new
  end

  # GET /leavtrackers/1/edit
  def edit
  end

  # POST /leavtrackers
  def create
    @leavetracker = LeaveTracker.new(leavetracker_params)
    respond_to do |format|
      if @leavetracker.save
        LeaveTrackerMailer.apply_leave_mail(@leavetracker).deliver
        format.html { redirect_to leave_trackers_path, notice: "LeaveTracker was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /leavetrackers/1 
  def update                                                    
    respond_to do |format|

      if @leavetracker.update(leavetracker_params) 
        format.html { redirect_to leave_trackers_path, notice: "LeaveTracker was successfully updated." }

      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
  
  # Approve/Reject toggal
  def approve_reject
    if @leavetracker.is_approved
      response = toggle_leave(false)
      LeaveTrackerMailer.reject_leave_mail(@leavetracker).deliver
    else
      response = toggle_leave(true)
      LeaveTrackerMailer.approve_leave_mail(@leavetracker).deliver
    end
    render json: response
    # binding.pry
  end

  # DELETE /timesheets/1 or /timesheets/1.json
  def destroy
    @leavetracker.destroy

    respond_to do |format|
      format.html { redirect_to leave_trackers_path, notice: "LeaveTracker was successfully destroyed." }
    end
  end

  ## Approve/Reject leave
  def toggle_leave(approve_status)
    @leavetracker.is_approved = approve_status
    if @leavetracker.save
      response = {
        success: true,
        title: "#{@leavetracker.is_approved ? 'Approve' : 'Reject'} a Leave",
        message: "Leave #{@leavetracker.is_approved ? 'approved' : 'rejected'} successfully!"
      }
    else
      response = {
        success: false,
        title: "#{@leavetracker.is_approved ? 'Approve' : 'Reject'} a Leave",
        message: "#{@leavetracker.is_approved ? 'Approving' : 'Rejecting'} leave failed, Try again later!"
      }
    end
    response
  end
 
  private

  def search_columns
    %w(reason)
  end

  def sort_column
    columns = %w(reason)
    columns[params[:order]['0'][:column].to_i - 1]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_leavetracker
    @leavetracker = LeaveTracker.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def leavetracker_params
  	params.require(:leave_tracker).permit(:from_date, :to_date, :reason, :is_approved, :user_id )
  end

end