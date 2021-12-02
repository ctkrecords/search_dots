class Dot < ActiveRecord::Base
  validates  :name, :presence => true
  belongs_to :company
  has_many :countries_dots

  #attr_accessible :description, :name, :is_required, :color
end

# == Schema Information
#
# Table name: dots
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  company_id   :integer
#  is_required  :boolean
#  is_universal :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_deleted   :boolean          default(FALSE)
#  color        :string(255)
#
