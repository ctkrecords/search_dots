class CreateWorkTimeframes < ActiveRecord::Migration[6.1]
  def change
    create_table :work_timeframes do |t|
      t.references :work_calendar
      t.integer :n_number
      t.boolean :is_disabled, :default=>false
      t.boolean :is_deleted, :default=>false
      t.date :starts_at
      t.date :ends_at

      t.timestamps
    end
    #add_index :work_timeframes, :work_calendar_id
  end
end
