class WorkCalendar < ActiveRecord::Base
	belongs_to :country
	has_many :work_timeframes
	# after_create :delay_build_time_frame_and_dot_score
	#attr_accessible :timeframe_type, :title, :year, :company_id, :country_id

  	def build_time_frame_and_dot_score(admin_id)
		if self.timeframe_type=="S"
			ini_date="#{self.year}/01/01".to_date
			(1..53).each do |week|
				ini=ini_date.at_beginning_of_week
				out=ini+4.days
				#puts "Week #{week} :: desde #{ini} hasta #{out}"
				WorkTimeframe.create(:work_calendar_id=>self.id, :n_number=>week, :starts_at=>ini, :ends_at=> out)
				ini_date=out+3.days
			end
		elsif self.timeframe_type=="M"
			ini_date="#{self.year}/01/01".to_date
			(1..12).each do |month|
				ini=ini_date.at_beginning_of_month
				out=ini_date.at_end_of_month
				WorkTimeframe.create(:work_calendar_id=>self.id, :n_number=>month, :starts_at=>ini, :ends_at=> out)
				ini_date=out+1.days
			end
		end

		hunters=TalentHunter.where(:company_id=>self.company_id, :country_id=>self.country_id)
		thd_verify=TalentHuntersDot.where(" talent_hunter_id in (?) and work_calendar_id=?",hunters.map(&:id), self.id)
		if thd_verify.size==0
			company=Company.includes(:companies_countries).where(:id=>self.company_id).first
			hunters.each do |hunter|
				company.companies_countries.where(:country_id=>self.country_id).first.dots.includes(:countries_dots).where("countries_dots.is_deleted=?",false).order("countries_dots.created_at").each do |dot| 
					new_goal=TalentHuntersDot.new
					new_goal.talent_hunter_id=hunter.id
					new_goal.work_calendar_id=self.id
					new_goal.dot_id=dot.id
					new_goal.created_by=admin_id
					new_goal.goal=0
					if new_goal.save
						self.work_timeframes.each do |timeframe|
							dot_score=DotsScored.new
							dot_score.total=0
							dot_score.talent_hunters_dot_id=new_goal.id
							dot_score.work_timeframe_id=timeframe.id
							dot_score.save
						end
					end
				end
			end
		end
	end

end

# == Schema Information
#
# Table name: work_calendars
#
#  id             :integer          not null, primary key
#  company_id     :integer
#  country_id     :integer
#  title          :string(255)
#  year           :string(255)
#  timeframe_type :string(255)
#  is_deleted     :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_work_calendars_on_country_id  (country_id)
#
