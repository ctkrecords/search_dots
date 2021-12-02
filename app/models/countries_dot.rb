class CountriesDot < ActiveRecord::Base
  belongs_to :companies_country
  belongs_to :dot
  #attr_accessible :is_deleted
  scope :active, lambda { where("is_deleted=?",false)} 
end

# == Schema Information
#
# Table name: countries_dots
#
#  id                   :integer          not null, primary key
#  dot_id               :integer
#  is_deleted           :boolean          default(FALSE)
#  assigned_by          :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  companies_country_id :integer
#
# Indexes
#
#  index_countries_dots_on_dot_id  (dot_id)
#
