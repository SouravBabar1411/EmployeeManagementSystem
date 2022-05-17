class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name, null: false 
      t.string :email, null: false 
      t.string :website
      t.boolean :is_approved, :boolean, :default => false, :null => false

      t.timestamps
    end
  end
end
