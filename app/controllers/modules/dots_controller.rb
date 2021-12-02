class Modules::DotsController < ApplicationController
	before_action :logged_admin
  layout "admins"
	add_breadcrumb :index, "/panel/home"
	add_breadcrumb :home, "/modules/dots"
	#add_breadcrumb :dot_country, :modules_dots_country_dots_path
	add_breadcrumb :dot_country, :modules_dots_country_dots_path, :only=>['country_dots','asign_dot_to_country','assing_dot_to']
	add_breadcrumb :dot_country_manage, :modules_dots_country_dots_path, :only=>['assing_dot_to']
	add_breadcrumb :dot_th_manage, :modules_dots_talent_hunter_dots_path,:only=>['talent_hunter_dots','assing_goals_for_dots']
	add_breadcrumb :dot_th_manage, :modules_dots_talent_hunter_dots_path, :only=>['talent_hunter_dots']
	add_breadcrumb :dot_th_manage_country, :modules_dots_talent_hunter_dots_path, :only=>['assing_goals_for_dots']

 	def index
 		@menu_scope="modules"
    @settings_scope="dot_module"

    #Estableciendo el pais del modulo
    if params[:country_id]
      @country=Country.where(:id=>params[:country_id]).first
    else
      params[:country_id]=nil
      @country=Country.where(:id=>current_admin.country_id).first
    end

    @dots=WorkTimeframe.new(params.permit![:date])
    #@dots=WorkTimeframe.new(date_func)
    puts ":::::::::::::::::::::::::::::::::::::::::::#{@dots.starts_at}"
    @work_calendar=WorkCalendar.includes(:work_timeframes).where(" work_calendars.company_id=? and  work_calendars.year=? and work_calendars.country_id=?",current_admin.company_id,@current_year,@country.id).first
    @current_timeframe=@work_calendar.work_timeframes.active.where("n_number=?",@current_week.to_i).first

    unless @dots.starts_at.nil?
      @selected_timeframe=@work_calendar.work_timeframes.active.where("n_number=?",@dots.starts_at.to_date.at_end_of_week.strftime("%U").to_i).first
    else
      @selected_timeframe=@current_timeframe
      @dots.starts_at=@current_timeframe.starts_at
    end

    #Recuperando los hunters activos del paies
 		@talent_hunters=TalentHunter.includes(:talent_hunters_dots=>[:dots_scoreds]).where(:country_id=>@country.id, :is_active=>true, :company_id=>current_admin.company_id)

 		@companies_dots=CountriesDot.includes(:companies_country).where(:companies_countries => {:country_id=>@country.id, :company_id=>current_admin.company_id})

    unless @work_calendar.nil?
      if params[:move]
        current_timeframe_param=params[:current_timeframe]
        if params[:move]=="backward"
          current_timeframe_param= current_timeframe_param.to_i-1
        elsif params[:move]=="forward"
          current_timeframe_param= current_timeframe_param.to_i+1
        end
        @current_timeframe=@work_calendar.work_timeframes.where(:n_number=>current_timeframe_param).first
      else
        @current_timeframe=@work_calendar.work_timeframes.where("n_number=?",@current_week.to_i).first
      end
    end

 	end

  def view
    @menu_scope="modules"
    @settings_scope="dot_module"
    @dots=WorkTimeframe.new(params.permit!(:date))

    #@hunter=TalentHunter.includes(:talent_hunters_dots=> [:dots_scoreds]).where(:id=>current_talent_hunter.id).first 
    @work_calendar=WorkCalendar.includes(:work_timeframes).where(" work_calendars.company_id=? and  work_calendars.year=? and work_calendars.country_id=?",current_admin.company_id,@current_year,current_admin.country_id).first

    @current_timeframe=@work_calendar.work_timeframes.active.where("n_number=?",@current_week.to_i).first

    if !@dots.starts_at.nil? and !@dots.ends_at.nil?
      @selected_timeframes=@work_calendar.work_timeframes.active.where("starts_at >= ? and ends_at <=? ",@dots.starts_at.to_date.at_beginning_of_week,@dots.ends_at.to_date.to_date.at_end_of_week-2.days)
    else
      @dots.ends_at=@current_timeframe.ends_at
      @dots.starts_at=@work_calendar.work_timeframes.active[@current_timeframe.n_number.to_i-8].starts_at
      @selected_timeframes=@work_calendar.work_timeframes.active.where("starts_at >= ? and ends_at <=? ",@dots.starts_at, @dots.ends_at)
    end
  end

  def assing_scored
  	if params[:scored_id] and params[:score_total]
  		dot_scored=DotsScored.find(params[:scored_id])
  		dot_scored.total=params[:score_total].to_i
  		if dot_scored.save
  			render :inline=>"true"
  			return
  		else
  			render :inline=>"false"
  			return
  		end
  	end
  	render :layout=>false
  	return
  end

end
