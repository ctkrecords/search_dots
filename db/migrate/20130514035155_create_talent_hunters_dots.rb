class CreateTalentHuntersDots < ActiveRecord::Migration[6.1]
  def change
    create_table :talent_hunters_dots do |t|
      t.string :year
      t.integer :created_by
      t.references :talent_hunter
      t.references :dot
      t.integer :goal
      t.boolean :is_deleted, :default=>false

      t.timestamps
    end
    #add_index :talent_hunters_dots, :talent_hunter_id
    #add_index :talent_hunters_dots, :dot_id
  end
end
