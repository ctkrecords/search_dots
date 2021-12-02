class AddAttachmentLogoToCompanies < ActiveRecord::Migration[6.1]
  def self.up
    change_table :companies do |t|
      t.has_attached_file :logo
    end
  end

  def self.down
    drop_attached_file :companies, :logo
  end
end
