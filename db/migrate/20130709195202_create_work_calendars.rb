class CreateWorkCalendars < ActiveRecord::Migration[6.1]
  def change
    create_table :work_calendars do |t|
      t.references :company
      t.references :country
      t.string :title
      t.string :year
      t.string :timeframe_type
      t.boolean :is_deleted, :default=>false
      
      t.timestamps
    end
    #add_index :work_calendars, :country_id
  end
end
