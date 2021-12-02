class AddActivationFieldsToAdmin < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :is_verified, :boolean, :default=>false
    add_column :admins, :token, :string, :default=>nil
    add_column :admins, :is_active, :boolean, :default=>false
  end
end