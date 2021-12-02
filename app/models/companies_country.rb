class CompaniesCountry < ActiveRecord::Base
  belongs_to :company
  belongs_to :country
  has_many :countries_dots
  has_many :dots, :through => :countries_dots
  #attr_accessible :is_deleted, :assigned_by, :country_id, :company_id
end

# == Schema Information
#
# Table name: companies_countries
#
#  id         :integer          not null, primary key
#  company_id :integer
#  country_id :integer
#  is_deleted :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_companies_countries_on_company_id  (company_id)
#  index_companies_countries_on_country_id  (country_id)
#
