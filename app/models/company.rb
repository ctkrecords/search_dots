class Company < ActiveRecord::Base
  
  has_many :companies_countries
  has_many :countries, :through => :companies_countries
  has_many :admins
  has_many :dots
  has_many :talent_hunters
  belongs_to :country
  

  has_attached_file :logo,
      :styles => {
        :mini => "45x45#",
        :thumb => "100x100#",
        :small  => "150x150>",
        :medium => "200x200" },
        :path => "/uploads/company_logos/:id/:style/:basename.:extension",
        :url => "/uploads/company_logos/:id/:style/:basename.:extension"

  validates_attachment_size :logo, :less_than => 5.megabytes
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg']

  #attr_accessible :approved_by, :contact_lastname, :contact_name, :email, :is_approved, :is_verified, :logo_url, :name, :recovery_token, :recovery_token_sent_at, :slogan, :verify_token, :website, :country_id, :phones, :logo

  def contact_full_name
    self.contact_name+ " " +self.contact_lastname
  end
end

# == Schema Information
#
# Table name: companies
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  country_id             :integer
#  website                :string(255)
#  slogan                 :string(255)
#  logo_url               :string(255)
#  contact_name           :string(255)
#  contact_lastname       :string(255)
#  phones                 :string(255)
#  email                  :string(255)
#  is_verified            :boolean          default(FALSE)
#  verify_token           :string(255)
#  recovery_token         :string(255)
#  recovery_token_sent_at :datetime
#  is_approved            :boolean          default(FALSE)
#  approved_by            :integer
#  is_deleted             :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  logo_file_name         :string(255)
#  logo_content_type      :string(255)
#  logo_file_size         :integer
#  logo_updated_at        :datetime
#
# Indexes
#
#  index_companies_on_country_id  (country_id)
#
