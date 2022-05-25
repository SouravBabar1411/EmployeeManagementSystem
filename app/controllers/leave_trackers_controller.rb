class LeaveTrackersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_leavetracker, only: %i[ edit update destroy ]
  # load_and_authorize_resource

  def index
    @leavetrackers = LeaveTracker.all
  end

  # def fetch_leavetrackers
  #   timesheets = Timesheet.all
  #   search_string = []
  #   ## Check if Search Keyword is Present & Write it's Query
  #   if params.has_key?('search') && params[:search].has_key?('value') && params[:search][:value].present?
  #     search_columns.each do |term|
  #       search_string << "#{term} ILIKE :search"
  #     end
  #     timesheets = timesheets.where(search_string.join(' OR '), search: "%#{params[:search][:value]}%")
  #   end

  #   if params["filters"].present?
  #     # filters = JSON.parse(params["filters"].gsub("=>", ":").gsub(":nil,", ":null,"))
  #     timesheets = timesheets.this_week
      
  #     case params["filters"]
  #       when "{\"timesheet\":[\"This Month\"]}" 
  #         timesheets = timesheets.this_month
  #       when "{\"timesheet\":[\"Last Month\"]}" 
  #         timesheets = timesheets.last_month
  #       when "{\"timesheet\":[\"This Year\"]}"
  #         timesheets = timesheets.this_year
  #       else
  #       Timesheet.all
  #       end
  #   end

  #    # timesheets = timesheets.order("#{sort_column} #{datatable_sort_direction}") unless sort_column.nil?
  #    # timesheets = timesheets.page(datatable_page).per(datatable_per_page)

  #   render json: {
  #       timesheets: timesheets.as_json,
  #       draw: params['draw'].to_i,
  #       recordsTotal: timesheets.count,
  #   }
  # end

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

  # DELETE /timesheets/1 or /timesheets/1.json
  def destroy
    @leavetracker.destroy

    respond_to do |format|
      format.html { redirect_to leave_trackers_path, notice: "LeaveTracker was successfully destroyed." }
    end
  end
 
  private

  def search_columns
    %w(description)
  end

  def sort_column
    columns = %w(description)
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
# from_date   :date             not null
#  to_date     :date             not null
#  reason      :text             not null
#  is_approved :boolean          default(FALSE), not null
#  user_id 