class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    change_column_null :users, :last_name, true
    change_column_null :users, :first_name, true
    change_column_null :users, :date_of_birth, true
  end
end
