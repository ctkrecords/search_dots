class CreateDotReports < ActiveRecord::Migration[6.1]
  def change
    create_table :dot_reports do |t|
      t.references :dot
      t.references :timeframe
      t.integer :total
      t.integer :spected

      t.timestamps
    end
    #add_index :dot_reports, :dot_id
    #add_index :dot_reports, :timeframe_id
  end
end
