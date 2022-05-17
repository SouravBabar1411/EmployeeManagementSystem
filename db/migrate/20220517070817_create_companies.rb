class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name, null: false 
      t.string :email, null: false 
      t.string :website, null: false 
      t.boolean :is_approved, :boolean, :default => false, :null => false
      t.string :add_approved_user_id_to_companies
      t.bigint :approved_user_id, null: false 
      t.references :admin_user, foreign_key: true

      t.timestamps
    end
    add_index :companies, :approved_user_id
  end
end
