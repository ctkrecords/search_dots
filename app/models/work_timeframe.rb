class WorkTimeframe < ActiveRecord::Base
  belongs_to :work_calendar
  #attr_accessible :ends_at, :is_deleted, :is_disabled, :n_number, :starts_at, :work_calendar_id, :month, :quarter

  scope :active,  lambda{ where("is_disabled=?",false)}

  def from_to_date
  	"#{self.starts_at} al #{self.ends_at}"
  end

  def set_month(month)
    if month
      if update_column(:month,month.to_i)
        if month.to_i<4
          n_quarter=1
        elsif month.to_i>3 and month.to_i<7
          n_quarter=2
        elsif month.to_i>6 and month.to_i<10
          n_quarter=3
        elsif month.to_i>9
          n_quarter=4
        end
        update_column(:quarter,n_quarter)
        update_other_month_quarter(self.starts_at,self.ends_at, month, n_quarter)
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def update_other_month_quarter(n_starts_at,n_ends_at,n_month,n_quarter)
      timeframes=WorkTimeframe.where(:starts_at=>n_starts_at, :ends_at=>n_ends_at)
      
      if timeframes.update_all(:month=>n_month, :quarter=>n_quarter)
        puts "#{timeframes.count} actualizados"
      end
  end  

  # def set_month
  #   cont=0
  #   week_of_month=0
  # 	date=self.starts_at.to_date
  # 	date.week_split.each do | w |
  # 		# cont+=1
  # 		nils=0
  # 		w.each do |wd|
  # 			nils+=1 if wd.nil?
  # 		end

  # 		week_size=w.count


  # 		is_of_this_mount=false

  # 		total_days=week_size-nils

  # 		unless total_days > 3
  # 			is_of_this_mount=true
  # 		end
  # 		strin=""
  # 		strin+= ":: La semana del #{w.compact.first} al #{w.last} tiene #{total_days} dia(s)"
  # 		if is_of_this_mount
  # 			strin += "y pertenece a este mes "
  # 			week_of_month+=1
  # 		else
  # 			strin += "y no pertenece a este mes"
  # 		end
  # 		puts strin
  # 	end
  # 	puts ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: \n Este mes tiene #{week_of_month} semanas laborales"
  # end

  
end

# == Schema Information
#
# Table name: work_timeframes
#
#  id               :integer          not null, primary key
#  work_calendar_id :integer
#  n_number         :integer
#  is_disabled      :boolean          default(FALSE)
#  is_deleted       :boolean          default(FALSE)
#  starts_at        :date
#  ends_at          :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  month            :integer          default(0)
#  quarter          :integer          default(0)
#
# Indexes
#
#  index_work_timeframes_on_work_calendar_id  (work_calendar_id)
#
