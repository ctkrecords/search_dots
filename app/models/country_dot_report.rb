class CountryDotReport < ActiveRecord::Base
  belongs_to :dot
  belongs_to :country
  belongs_to :work_timeframe
  #attr_accessible :spected, :total

  # def get_totals(country_id, dot_id, work_timeframe_id)
  #   self.total=DotsScored.includes(:work_timeframe, :talent_hunters_dot=>[:dot, {:talent_hunter=>:country}]).where("countries.id=? and dots.id=? and work_timeframes.id=?",country_id,dot_id,work_timeframe_id).sum("dots_scoreds.total")
  # end

  def get_totals
  	self.total=DotsScored.includes(:work_timeframe, :talent_hunters_dot=>[:dot, {:talent_hunter=>:country}]).where("countries.id=? and dots.id=? and work_timeframes.id=?",self.country_id,self.dot_id,self.work_timeframe_id).sum("dots_scoreds.total")
  end
end

# == Schema Information
#
# Table name: country_dot_reports
#
#  id                :integer          not null, primary key
#  dot_id            :integer
#  total             :integer
#  spected           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  work_timeframe_id :integer
#  country_id        :integer
#
# Indexes
#
#  index_country_dot_reports_on_dot_id  (dot_id)
#
