class Country < ActiveRecord::Base
	validates_presence_of :name, :shortname
  	#attr_accessible :id,:name, :shortname

  	has_many :admins
  	has_many :talent_hunters

  	belongs_to :company
  	
  	has_many :companies_countries
  	has_many :work_calendars
  end

# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  shortname  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
