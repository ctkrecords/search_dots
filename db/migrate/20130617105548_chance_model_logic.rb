class ChanceModelLogic < ActiveRecord::Migration[6.1]
  def up
  	remove_column :countries_dots, :country_id
  	add_column :countries_dots, :companies_country_id, :integer 
  end

  def down
  	remove_column :countries_dots, :companies_country_id
  	add_column :countries_dots, :country_id, :integer 
  end
end
