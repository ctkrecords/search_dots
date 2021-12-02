class TalentHuntersDot < ActiveRecord::Base
  belongs_to :talent_hunter
  belongs_to :dot
  has_many :dots_scoreds
  #attr_accessible :created_by, :goal, :year

  validates_uniqueness_of :dot_id, :scope=> [:talent_hunter_id, :work_calendar_id]#, message: "Email ya registrado" }

  def update_other_goals(calendar, dot, meta)
  	dot_metas=TalentHuntersDot.where(:work_calendar_id=>calendar, :dot_id=>dot)
  	
  	if dot_metas.update_all(:goal=>meta)
  	  puts "#{dot_metas.count} actualizados"
  	end
  end

end

# == Schema Information
#
# Table name: talent_hunters_dots
#
#  id               :integer          not null, primary key
#  created_by       :integer
#  talent_hunter_id :integer
#  dot_id           :integer
#  goal             :integer
#  is_deleted       :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  work_calendar_id :integer
#
# Indexes
#
#  index_talent_hunters_dots_on_dot_id            (dot_id)
#  index_talent_hunters_dots_on_talent_hunter_id  (talent_hunter_id)
#
