class CreateDotsScoreds < ActiveRecord::Migration[6.1]
  def change
    create_table :dots_scoreds do |t|
      t.references :talent_hunters_dot
      t.references :work_timeframe
      t.integer :total, :default=>0
      t.decimal :scored_percentage,:default=>0.0

      t.timestamps
    end
    #add_index :dots_scoreds, :talent_hunters_dot_id
    #add_index :dots_scoreds, :work_timeframe_id
  end
end
