class AdminModules::DotsController < ApplicationController
	before_action :logged_company_admin
  layout "admins"
  add_breadcrumb :index, "/admin_modules/panel/home"
  add_breadcrumb :settings, "/admin_modules/panel/settings"
  add_breadcrumb :home, "/modules/dots"
  before_action :breadcrumb_dot

  def index
    @menu_scope="settings"
    @settings_scope="dot_settings"
    @dot_scope="dots"
    @dots=Dot.where("company_id=? and is_deleted=?",current_admin.company_id,false).order("created_at ASC")
    @dot=Dot.new
  end

  def create
    dot = Dot.new(params[:dot])
    company=Company.find(current_admin.company_id)
    dot.company_id=company.id
    if dot.save
      if dot.is_required
        company.companies_countries.each do |cc_country|
          new_country_dot= CountriesDot.new
          new_country_dot.dot_id=dot.id
          new_country_dot.assigned_by= current_admin.id
          new_country_dot.companies_country_id=cc_country.id
          new_country_dot.save
          work_calendar=WorkCalendar.where(:company_id=>company.id, :country_id=>cc_country.country_id, :year=>@current_year).first
          unless work_calendar.nil?
            cc_country.country.talent_hunters.where(:company_id=>current_admin.company_id).each do |hunter|
              new_goal=TalentHuntersDot.new
              new_goal.talent_hunter_id=hunter.id
              new_goal.work_calendar_id=work_calendar.id
              new_goal.dot_id=dot.id
              new_goal.created_by=current_admin.id
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
          end
        end
      end
      flash[:notice] = 'Dot asignado correctamente'
    else
      flash[:eroor] = 'Error al intertar'
    end
    redirect_to "/admin_modules/dots/index"
  end

  def update_dot
    @dot = Dot.find(params[:id])

    if @dot.update_attributes(params[:dot])
      redirect_to "/admin_modules/dots/index", notice: 'Dot was successfully updated.'
    end
    
  end

  def delete
    if params[:id]
      dot=Dot.find(params[:id])
      dot.is_deleted=true
      if dot.save 
        countries_dots=CountriesDot.where(:dot_id=>dot.id)
        countries_dots.map {|cdot| cdot.update_attribute("is_deleted",true) }
      end
      flash[:notice]="Dots removido"
    end
    redirect_to "/admin_modules/dots/index"
  end

  def remove_country_dots
    if params[:id]
      dot=CountriesDot.find(params[:id])
      dot.update_attribute("is_deleted",true)
      flash[:notice]="Dots removido"
    end
    redirect_to "/admin_modules/dots/countries"
    
  end

  def countries

    @menu_scope="settings"
    @settings_scope="dot_settings"
    @dot_scope="dotscountries"
    @company=Company.find(current_admin.company_id)
  end

  def assing_dot_to
    @country=CompaniesCountry.find(params[:id])
    work_calendar=WorkCalendar.where(:company_id=>current_admin.company.id, :country_id=>@country.country_id, :year=>@current_year).first
    if request.post? and params[:new_dots] and !work_calendar.nil?
      params[:new_dots][:dots].each do |dot|
        unless dot.blank?
          find_dot=CountriesDot.where(:companies_country_id=>params[:id],:dot_id=>dot)
          if find_dot.size==0
            new_dot_for = CountriesDot.new
            new_dot_for.assigned_by= current_admin.id
            new_dot_for.companies_country_id=params[:id]
            new_dot_for.dot_id=dot
            new_dot_for.assigned_by=current_admin.id
            if new_dot_for.save
              flash[:notice] = "Dots asignados correctamente"
              
              unless work_calendar.nil?
                @country.country.talent_hunters.where(:company_id=>current_admin.company_id).each do |hunter|
                  new_goal=TalentHuntersDot.new
                  new_goal.talent_hunter_id=hunter.id
                  new_goal.work_calendar_id=work_calendar.id
                  new_goal.dot_id=dot
                  new_goal.created_by=current_admin.id

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
              end
            else
              flash[:notice] = "Error al intertar Agregar"
            end
          else
              find_dot.first.update_attribute("is_deleted",false)
              flash[:notice] = "Dot restaurado con su posible historial"
          end
        end
      end
    elsif request.post? and params[:new_dots] and work_calendar.nil?
      params[:new_dots][:dots].each do |dot|
        find_dot=CountriesDot.where(:companies_country_id=>params[:id],:dot_id=>dot)
        if find_dot.size==0
          new_dot_for = CountriesDot.new
          new_dot_for.assigned_by= current_admin.id
          new_dot_for.companies_country_id=params[:id]
          new_dot_for.dot_id=dot
          if new_dot_for.save
            flash[:notice] = "Dots asignados correctamente"
          end
        end
      end
    end
    redirect_to "/admin_modules/dots/countries"
  end

 	def delete_dot_from
 		if params[:dot] and params[:id]
 			country_dot=CountriesDot.find(:first, :conditions=>["country_id=? and dot_id=?",params[:id],params[:dot]])
 			country_dot.destroy
 			flash[:notice]="Dots removido"
 		else

 		end
 		redirect_to "/modules/dots/assing_dot_to/#{params[:id]}"
 	end

 	def talent_hunters

    @menu_scope="settings"
    @settings_scope="dot_settings"
    @dot_scope="dotshunters"
 		@countries=current_admin.company.companies_countries
    if params[:country_id]
      @selected_country=current_admin.company.companies_countries.where(:country_id=>params[:country_id]).first
    else
      @selected_country=current_admin.company.companies_countries.first
    end
    if params[:work_calendar_id]
      @work_calendar=WorkCalendar.where(:id=>params[:work_calendar_id]).first
    else
      @work_calendar=WorkCalendar.where(:company_id=>current_admin.company_id, :country_id=>@selected_country.country_id, :year=>@current_year).first
    end

    unless @work_calendar
      flash[:notice] = "No hay calendarios laborales"
      redirect_to "/admin_modules/panel/work_calendar" unless @work_calendar
    end
 	end

  def assing_goals_for_dots

    @menu_scope="settings"
    @settings_scope="dot_settings"
    @dot_scope="dotshunters"
    @conditions=[" company_id=#{current_admin.company_id} and is_active=? ",true]

  	if params[:id]
  		@country=CompaniesCountry.find(params[:id])
      @hunter=@country.country.talent_hunters.where(@conditions).first
    end
  end

  def assing_goals
  	if params[:goal_id] and params[:goal_value]
  		goal_dot=TalentHuntersDot.find(params[:goal_id])
  		goal_dot.goal=params[:goal_value]
  		if goal_dot.save
         goal_dot.update_other_goals(goal_dot.work_calendar_id,goal_dot.dot_id,params[:goal_value])
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

  def breadcrumb_dot
    @menu_scope="settings"
    @settings_scope="dot_settings"
  end
end
