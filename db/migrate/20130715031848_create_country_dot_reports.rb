class CreateCountryDotReports < ActiveRecord::Migration[6.1]
  def change
    create_table :country_dot_reports do |t|
      t.references :dot
      t.references :companies_country
      t.references :timeframe
      t.integer :total
      t.integer :spected

      t.timestamps
    end
    #add_index :country_dot_reports, :dot_id
    #add_index :country_dot_reports, :companies_country_id
    #add_index :country_dot_reports, :timeframe_id
  end
end
