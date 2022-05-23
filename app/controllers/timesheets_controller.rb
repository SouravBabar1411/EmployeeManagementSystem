class TimesheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_timesheet, only: %i[ edit update destroy ]
  # timesheet listing
  def index
    @timesheets = Timesheet.all
  end

  def fetch_timesheets
    timesheets = Timesheet.all
    search_string = []
    # binding.pry
    ## Check if Search Keyword is Present & Write it's Query
    if params.has_key?('search') && params[:search].has_key?('value') && params[:search][:value].present?
      search_columns.each do |term|
        search_string << "#{term} ILIKE :search"
      end
      timesheets = timesheets.where(search_string.join(' OR '), search: "%#{params[:search][:value]}%")
    end

    timesheets = timesheets.order("#{sort_column} #{datatable_sort_direction}") unless sort_column.nil?
    timesheets = timesheets.page(datatable_page).per(datatable_per_page)

    render json: {
        timesheets: timesheets.as_json,
        draw: params['draw'].to_i,
        recordsTotal: timesheets.count,
    }
  end

  # Display Timesheet Data
  def show
  end

  # GET /timesheets/new
  def new
    @timesheet = Timesheet.new
    # @timesheet = current_user.timesheets.build
  end

  # GET /timesheets/1/edit
  def edit
  end

  # POST /timesheets or /timesheets.json
  def create
    @timesheet = Timesheet.new(timesheet_params)
    respond_to do |format|
      if @timesheet.save
        format.html { redirect_to timesheets_path, notice: "Timesheet was successfully created." }
        format.json { render :show, status: :created, location: @timesheet }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /timesheets/1 or /timesheets/1.json
  def update                                                    
    respond_to do |format|
      if @timesheet.update(timesheet_params) && params[:timesheet][:is_approved].include?("1")
        TimesheetMailer.send_timesheet_approve_email(@timesheet).deliver
        format.html { redirect_to timesheets_path, notice: "Timesheet was successfully updated." }
        # format.json { render :show, status: :ok, location: @timesheet }
      elsif  @timesheet.update(timesheet_params)
        format.html { redirect_to timesheets_path, notice: "Timesheet was successfully updated." }
      elsif
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timesheets/1 or /timesheets/1.json
  def destroy
    @timesheet.destroy

    respond_to do |format|
      format.html { redirect_to timesheets_path, notice: "Timesheet was successfully destroyed." }
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
  def set_timesheet
    @timesheet = Timesheet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def timesheet_params
    params.require(:timesheet).permit(:time, :description, :is_approved, :user_id, :project_id, :job_id)
  end
end
