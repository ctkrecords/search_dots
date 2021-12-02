class CreateTalentHunters < ActiveRecord::Migration[6.1]
  def change
    create_table :talent_hunters do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.references :country
      t.references :company
      t.boolean :is_active, :default=>true
      t.boolean :is_deleted, :default=>false

      t.timestamps
    end
    #add_index :talent_hunters, :country_id
  end
end
