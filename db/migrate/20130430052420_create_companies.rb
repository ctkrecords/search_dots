class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.references :country
      t.string :website
      t.string :slogan
      t.string :logo_url
      t.string :contact_name
      t.string :contact_lastname
      t.string :phones
      t.string :email
      t.boolean :is_verified, :default=>false
      t.string :verify_token
      t.string :recovery_token
      t.datetime :recovery_token_sent_at
      t.boolean :is_approved, :default=>false
      t.integer :approved_by
      t.boolean :is_deleted, :default=>false

      t.timestamps
    end
    #add_index :companies, :country_id
  end
end
