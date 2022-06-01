class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tokens, :json
    add_index :users, [:uid, :provider], unique: true
  end
end
