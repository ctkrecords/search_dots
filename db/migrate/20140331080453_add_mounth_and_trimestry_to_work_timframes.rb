class AddMounthAndTrimestryToWorkTimframes < ActiveRecord::Migration[6.1]
  def change
  	add_column :work_timeframes, :month, :integer, :default=> 0
  	add_column :work_timeframes, :quarter, :integer, :default=> 0

  end
end
