class DotReport < ActiveRecord::Base
  belongs_to :dot
  belongs_to :work_timeframe
  #attr_accessible :spected, :total
end

# == Schema Information
#
# Table name: dot_reports
#
#  id                :integer          not null, primary key
#  dot_id            :integer
#  total             :integer
#  spected           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  work_timeframe_id :integer
#
# Indexes
#
#  index_dot_reports_on_dot_id  (dot_id)
#
