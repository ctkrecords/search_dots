class AddWorkCalendarToTalentHunterDots < ActiveRecord::Migration[6.1]
  def up
  	remove_column :talent_hunters_dots, :year
  	add_column :talent_hunters_dots, :work_calendar_id, :integer
  end

  def down
  	remove_column :talent_hunters_dots, :work_calendar_id
  	add_column :talent_hunters_dots, :year
  end
end
