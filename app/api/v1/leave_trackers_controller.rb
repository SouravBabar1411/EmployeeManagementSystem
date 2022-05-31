module Api
 module V1
 end
end
class Api::V1::LeaveTrackersController < ApplicationController
  def index
    @leavetrackers = LeaveTracker.all
     respond_to do |format|
      format.json { render :json => @leavetrackers.to_json, status => :ok }
    end
  end
end