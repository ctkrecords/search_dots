class AdminModules::PanelController < ApplicationController
  #before_filter :logged_company_admin
  before_action :logged_company_admin
  layout "admins"
  add_breadcrumb :index, "/admin_modules/panel/home"
  add_breadcrumb :settings, "/admin_modules/panel/settings", :only=>"settings"

  def index
  	render :layout=> 'home'
  end

  def home
    @section_scope="Home"
  	@menu_scope="home"
  end

  def my_profile
    @admin = Admin.find(current_admin.id)

    respond_to do |format|
      format.html { render :profile}
    end
  end

  def settings
    @section_scope="Home"
    @menu_scope="settings"
    @settings_scope="general_info"
    @company=current_admin.company

    if request.post?

      respond_to do |format|
        if @company.update_attributes(params[:company])
          format.html { redirect_to admin_panel_settings_path, notice: 'Company was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "settings" }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def work_calendar
    @section_scope="Home"
    @menu_scope="settings"
    @settings_scope="work_calendar"
    
    @work_calendars = WorkCalendar.where(:company_id => current_admin.company_id, :is_deleted=>false, :year=> session[:year]).order("created_at DESC")
    @work_calendar = WorkCalendar.new
  end

  def new_calendar
    @work_calendar = WorkCalendar.new(params[:work_calendar])
    @work_calendar.company_id=current_admin.company_id

    if @work_calendar.save
      @work_calendar.delay.build_time_frame_and_dot_score(current_admin.id)
    end
    redirect_to action: :work_calendar
  end

  def delete_calendar
    if params[:id]
      @work_calendar = WorkCalendar.where(:id=>params[:id]).first
      @work_calendar.is_deleted=true
      @work_calendar.save
      redirect_to action: :work_calendar
    end  
  end

  def work_timeframes_set_month
    if params[:id] and params[:month]
      @work_timeframe = WorkTimeframe.find(params[:id])
      res=@work_timeframe.set_month(params[:month])
      
      respond_to do |format|
        format.html # index.html.erb
        format.js
      end
    end
  end
  def work_timeframes
    @section_scope="Home"
    @menu_scope="settings"
    @settings_scope="work_calendar"

    if params[:id]
      @work_calendar= WorkCalendar.where(:id=>params[:id]).first
      @work_timeframes = @work_calendar.work_timeframes.where("is_deleted=false").order("n_number ASC")
    end  
  end

  def edit_work_timesframe
    if params[:id]
      @work_timeframe = WorkTimeframe.find(params[:id])
    end
  end

  def disable_timeframe
    if params[:id]
      @work_timeframe = WorkTimeframe.where(:id=>params[:id]).first
      @work_timeframe.is_disabled=!@work_timeframe.is_disabled
      @work_timeframe.save
      redirect_to action: :work_timeframes, :id=>"#{@work_timeframe.work_calendar.id}"
    end  
  end

  def delete_timeframe
    if params[:id]
      @work_timeframe = WorkTimeframe.where(:id=>params[:id]).first
      @work_timeframe.is_deleted=true
      @work_timeframe.save
      redirect_to action: :work_timeframes, :id=>"#{@work_timeframe.work_calendar.id}"
    end 
  end
end