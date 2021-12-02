class CreateCompaniesCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :companies_countries do |t|
      t.references :company
      t.references :country
      t.boolean :is_deleted, :default=>false

      t.timestamps
    end
    #add_index :companies_countries, :company_id
    #add_index :companies_countries, :country_id
  end
end
