class AdminType < ActiveRecord::Base
  #attr_accessible :description, :name
  has_many :admins
  #scopes
  scope :no_root,  lambda{ where("id<>1")}
end

# == Schema Information
#
# Table name: admin_types
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  is_deleted  :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
