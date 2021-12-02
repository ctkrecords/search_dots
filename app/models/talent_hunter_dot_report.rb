class TalentHunterDotReport < ActiveRecord::Base
  belongs_to :dot
  belongs_to :talent_hunter
  belongs_to :work_timeframe
  #attr_accessible :spected, :total
end

# == Schema Information
#
# Table name: talent_hunter_dot_reports
#
#  id                :integer          not null, primary key
#  dot_id            :integer
#  talent_hunter_id  :integer
#  total             :integer
#  spected           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  work_timeframe_id :integer
#
# Indexes
#
#  index_talent_hunter_dot_reports_on_dot_id  (dot_id)
#
