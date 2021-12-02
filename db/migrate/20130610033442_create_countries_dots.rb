class CreateCountriesDots < ActiveRecord::Migration[6.1]
  def change
    create_table :countries_dots do |t|
      t.references :country
      t.references :dot
      t.boolean :is_deleted, :default=>false
      t.integer :assigned_by, :default=>nil

      t.timestamps
    end
    #add_index :countries_dots, :country_id
    #add_index :countries_dots, :dot_id
  end
end
