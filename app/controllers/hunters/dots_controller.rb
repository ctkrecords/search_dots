class Hunters::DotsController < ApplicationController
  before_action :logged_hunter
  layout "hunter"
  add_breadcrumb :home, "/hunterS/dots"
  before_action :set_timeframe_dot, :only=>['show','edit']

  def index
    @menu_scope="modules"
    @settings_scope="dot_module"
    @dots=WorkTimeframe.new(params.permit![:date])

    @hunter=TalentHunter.includes(:talent_hunters_dots=> [:dots_scoreds]).where(:id=>current_talent_hunter.id).first 
    @work_calendar=WorkCalendar.includes(:work_timeframes).where(" work_calendars.company_id=? and  work_calendars.year=? and work_calendars.country_id=?",current_talent_hunter.company_id,@current_year,current_talent_hunter.country_id).first

    @current_timeframe=@work_calendar.work_timeframes.active.where("n_number=?",@current_week).first

    if !@dots.starts_at.nil? and !@dots.ends_at.nil?
      @selected_timeframes=@work_calendar.work_timeframes.active.where("starts_at >= ? and ends_at <=? ",@dots.starts_at.to_date.at_beginning_of_week,@dots.ends_at.to_date.to_date.at_end_of_week-2.days)
    else
      @selected_timeframes=@work_calendar.work_timeframes.active.where("month > ? and month <= ?",0,@current_timeframe.month).order("n_number DESC")
      @dots.ends_at=@selected_timeframes.first.ends_at
      @dots.starts_at=@selected_timeframes.last.starts_at
    end
  end

  # GET /dots/1
  # GET /dots/1.json
  def show

    if params[:modal]
      render :layout=>false
    end
  end

  # GET /dots/1/edit
  def edit
    
    if params[:modal]
        render :layout=>false
    end
  end

  # PUT /dots/1
  # PUT /dots/1.json
  def update
    @dot = Dot.find(params[:id])

    respond_to do |format|
      if @dot.update_attributes(params[:dot])
        format.html { redirect_to @dot, notice: 'Dot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dot.errors, status: :unprocessable_entity }
      end
    end
  end


  def assing_dot
    if params[:dot_id] and params[:dot_total]
      dot_scored=DotsScored.find(params[:dot_id])
      dot_scored.total=params[:dot_total].to_i
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

  def set_timeframe_dot
    @menu_scope="modules"
    @settings_scope="dot_module"
    @work_timeframe = WorkTimeframe.find(params[:id])
    @hunter=TalentHunter.includes(:talent_hunters_dots=> [:dots_scoreds]).where(:id=>current_talent_hunter.id).first
    
  end

end
