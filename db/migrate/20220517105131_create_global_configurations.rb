class CreateGlobalConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :global_configurations do |t|
      t.string :config_key, null: false
      t.integer :config_value, null: false
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
