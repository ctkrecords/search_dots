class CreateTalentHunterDotReports < ActiveRecord::Migration[6.1]
  def change
    create_table :talent_hunter_dot_reports do |t|
      t.references :dot
      t.references :talent_hunter
      t.references :timeframe
      t.integer :total
      t.integer :spected

      t.timestamps
    end
    #add_index :talent_hunter_dot_reports, :dot_id
    #add_index :talent_hunter_dot_reports, :talent_hunter_id
    #add_index :talent_hunter_dot_reports, :timeframe_id
  end
end
