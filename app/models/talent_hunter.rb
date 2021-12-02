class TalentHunter < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me

  has_attached_file :photo,
      :styles => {
        :mini => "45x45#",
        :thumb => "100x100#",
        :small  => "150x150>",
        :medium => "200x200" },
        :default_url => "http://s3-us-west-2.amazonaws.com/searchinfiles/uploads/talent_hunters/26/mini/user_famele.png",
      :path => "/uploads/talent_hunters/:id/:style/:basename.:extension",
      :url => "/uploads/talent_hunters/:id/:style/:basename.:extension"

  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg']

  belongs_to :country
  belongs_to :company
  has_many :talent_hunters_dots
  has_many :dots, :through => :talent_hunters_dots

  has_many :dots_scoreds, :through => :talent_hunters_dots  

  validates :firstname, :lastname, :email, :country_id, :presence=>true
  #attr_accessible :email, :firstname, :is_active, :lastname, :country_id, :photo, :company_id, :include_in_reports

  scope :actives, lambda { |company| where("company_id=? and  is_active=?",company,true)} 
  scope :active, lambda { where("is_active=?",true)}
  scope :for_report, lambda { where("is_active=? and include_in_reports=?",true,true)}

  def full_name
    self.firstname + " " + self.lastname
  end


  def create_scored_for_workcalendar(year,admin)
    work_calendar=WorkCalendar.where(:country_id=>self.country_id, :company_id=> self.company_id, :year=>year.to_s).first

    if work_calendar
      has_dot_assigned=TalentHuntersDot.where(:work_calendar_id=>work_calendar.id, :talent_hunter_id=>self.id).count
      # if has_dot_assigned==0
        company.companies_countries.where(:country_id=>self.country_id).first.dots.order("id ASC").each do |dot| 
          new_goal=TalentHuntersDot.new
          new_goal.talent_hunter_id=self.id
          new_goal.work_calendar_id=work_calendar.id
          new_goal.dot_id=dot.id
          new_goal.created_by=admin
          new_goal.goal=0
          if new_goal.save
            work_calendar.work_timeframes.each do |timeframe|
              dot_score=DotsScored.new
              dot_score.talent_hunters_dot_id=new_goal.id
              dot_score.work_timeframe_id=timeframe.id
              dot_score.save
            end
          end
        end
      # end
    end
  end

end

# == Schema Information
#
# Table name: talent_hunters
#
#  id                     :integer          not null, primary key
#  firstname              :string(255)
#  lastname               :string(255)
#  email                  :string(255)
#  country_id             :integer
#  company_id             :integer
#  is_active              :boolean          default(TRUE)
#  is_deleted             :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  photo_file_name        :string(255)
#  photo_content_type     :string(255)
#  photo_file_size        :integer
#  photo_updated_at       :datetime
#  encrypted_password     :string(255)      not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  photo                  :string(255)
#  include_in_reports     :boolean          default(TRUE)
#
# Indexes
#
#  index_talent_hunters_on_country_id            (country_id)
#  index_talent_hunters_on_email                 (email) UNIQUE
#  index_talent_hunters_on_reset_password_token  (reset_password_token) UNIQUE
#
