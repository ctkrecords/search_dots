class AddIncludeInReportToTalentHunter < ActiveRecord::Migration[6.1]
  def change
  	add_column :talent_hunters, :include_in_reports, :boolean, :default=> true
  end
end
