class AddCompanyIdToAdmins < ActiveRecord::Migration[6.1]
  def change
  	add_column :admins, :company_id, :integer
  end
end
