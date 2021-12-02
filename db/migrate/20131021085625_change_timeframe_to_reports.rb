class ChangeTimeframeToReports < ActiveRecord::Migration[6.1]
  def up

  	remove_column :dot_reports, :timeframe_id
  	remove_column :talent_hunter_dot_reports, :timeframe_id
  	remove_column :country_dot_reports, :timeframe_id
    remove_column :country_dot_reports, :companies_country_id

  	add_column :dot_reports, :work_timeframe_id, :integer
  	add_column :talent_hunter_dot_reports, :work_timeframe_id, :integer
    add_column :country_dot_reports, :work_timeframe_id, :integer
    add_column :country_dot_reports, :country_id, :integer
  end

  def down
  	add_column :dot_reports, :timeframe_id
    add_column :talent_hunter_dot_reports, :timeframe_id
    add_column :country_dot_reports, :timeframe_id

    remove_column :dot_reports, :work_timeframe_id
    remove_column :talent_hunter_dot_reports, :work_timeframe_id
    remove_column :country_dot_reports, :work_timeframe_id
    remove_column :country_dot_reports, :country_id, :integer
  end
end

