class RemoveIsApproveFromLeaveTrackes < ActiveRecord::Migration[5.2]
  def change
    remove_column :leave_trackers, :is_approved
    add_column :leave_trackers, :is_approved ,:boolean, default: false
  end
end
