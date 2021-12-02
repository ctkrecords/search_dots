class DotsScored < ActiveRecord::Base
  belongs_to :talent_hunters_dot
  belongs_to :work_timeframe
  #attr_accessible :scored_percentage, :total
end

# == Schema Information
#
# Table name: dots_scoreds
#
#  id                    :integer          not null, primary key
#  talent_hunters_dot_id :integer
#  work_timeframe_id     :integer
#  total                 :integer          default(0)
#  scored_percentage     :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_dots_scoreds_on_talent_hunters_dot_id  (talent_hunters_dot_id)
#  index_dots_scoreds_on_work_timeframe_id      (work_timeframe_id)
#
