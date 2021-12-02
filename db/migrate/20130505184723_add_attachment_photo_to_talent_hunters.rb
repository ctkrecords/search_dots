class AddAttachmentPhotoToTalentHunters < ActiveRecord::Migration[6.1]
  def self.up
    change_table :talent_hunters do |t|
      t.has_attached_file :photo
    end
  end

  def self.down
    drop_attached_file :talent_hunters, :photo
  end
end
