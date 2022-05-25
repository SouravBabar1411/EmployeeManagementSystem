class RemoveColumnTimesheet < ActiveRecord::Migration[5.2]
  def change
    remove_column :timesheets, :current_date
    change_column :timesheets, :time, :string
  end
end
