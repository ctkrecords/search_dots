class Hunters::HomeController < ApplicationController
  before_action :logged_hunter
  layout "hunter"

  def dashboard

    @hunter=TalentHunter.includes(:talent_hunters_dots=> [:dots_scoreds]).where(:id=>current_talent_hunter.id).first 

    @menu_scope="home"

    @work_calendar=WorkCalendar.includes(:work_timeframes).where(" work_calendars.company_id=? and  work_calendars.year=? and work_calendars.country_id=?",current_talent_hunter.company_id,@current_year,current_talent_hunter.country_id).first
    @talent_hunters_dots=@hunter.talent_hunters_dots.includes(:dots_scoreds, :dot).where(:work_calendar_id=>@work_calendar.id).order("id ASC")

    @current_timeframe=@work_calendar.work_timeframes.active.where("n_number=?",@current_week).first
    @selected_timeframes=@work_calendar.work_timeframes.active.where("month = ?",@current_timeframe.month).order("n_number DESC")
  end

  def profile
    @talent_hunter=current_talent_hunter    
  end

  def edit
    @talent_hunter=current_talent_hunter
  end

  def save_profile  
    @talent_hunter = TalentHunter.find(current_talent_hunter.id)

    params[:talent_hunter].delete(:password) if params[:talent_hunter][:password].blank?
    params[:talent_hunter].delete(:password_confirmation) if params[:talent_hunter][:password_confirmation].blank? 

    respond_to do |format|
      if @talent_hunter.update_attributes(params[:talent_hunter])
        sign_in(@talent_hunter, :bypass => true)
        format.html { redirect_to hunters_my_profile_path, notice: 'Talent hunter was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
end