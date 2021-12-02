class AdminModules::TalentHuntersController < ApplicationController
  before_action :logged_company_admin
  before_action :breadcrumb_talent
  layout "admins"
  add_breadcrumb :index, "/admin_modules/panel/home"
  add_breadcrumb :settings, "/admin_modules/panel/settings"
  add_breadcrumb :home, "/admin_modules/admins/index"
  add_breadcrumb :new, :new_company_path, :only=>['new','create']
  add_breadcrumb :edit, :new_company_path, :only=>['edit','update']
  add_breadcrumb :show, :company_path, :only=>['show','countries','admins']
  add_breadcrumb :countries, "/settings/countries", :only=>['countries']
  add_breadcrumb :admins, "/settings/admins", :only=>['admins']

  # GET /talent_hunters
  # GET /talent_hunters.json
  def index
    @menu_scope="settings"
    @settings_scope="talent_hunters"
    @url="/panel/settings"
   
    @talent_hunters = TalentHunter.where(:company_id=>current_admin.company_id, :is_deleted=>false)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @talent_hunters }
    end
  end

  # GET /talent_hunters/1
  # GET /talent_hunters/1.json
  def show
    @talent_hunter = TalentHunter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @talent_hunter }
    end
  end

  # GET /talent_hunters/new
  # GET /talent_hunters/new.json
  def new
    @url="/panel/settings"
    @talent_hunter = TalentHunter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @talent_hunter }
    end
  end

  # GET /talent_hunters/1/edit
  def edit
    @url="/panel/settings"
    @talent_hunter = TalentHunter.find(params[:id])
  end

  # POST /talent_hunters
  # POST /talent_hunters.json
  def create
    @url="/panel/settings"
    @talent_hunter = TalentHunter.new(params[:talent_hunter])
    company=current_admin.company
    @talent_hunter.company_id=company.id
    work_calendar=WorkCalendar.where(:company_id=>company.id, :country_id=>@talent_hunter.country_id, :year=>@current_year).first
    respond_to do |format|
      if @talent_hunter.save
        #countries_dots=CountriesDot.where("companies_countries.company_id=? and companies_countries.country_id=?",current_admin.company_id,@talent_hunter.country_id).dots.each do |dot|
        unless work_calendar.nil?
          company.companies_countries.where(:country_id=>@talent_hunter.country_id).first.dots.order("id ASC").each do |dot| 
            new_goal=TalentHuntersDot.new
            new_goal.talent_hunter_id=@talent_hunter.id
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
        format.html { redirect_to admin_modules_talent_hunter_path(@talent_hunter), notice: 'Talent hunter was successfully created.' }
        format.json { render json: admin_modules_talent_hunter_path(@talent_hunter), status: :created, location: @talent_hunter }
      else
        format.html { render action: "new" }
        format.json { render json: @talent_hunter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /talent_hunters/1
  # PUT /talent_hunters/1.json
  def update
    @talent_hunter = TalentHunter.find(params[:id])

    respond_to do |format|
      if @talent_hunter.update_attributes(params[:talent_hunter])
        format.html { redirect_to admin_modules_talent_hunter_path(@talent_hunter), notice: 'Talent hunter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @talent_hunter.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_password
    @hunter = TalentHunter.find(params[:id])
    respond_to do |format|
      format.html { render :change_password}
      format.json { render :change_password, json: @hunter }
    end
  end

  def update_password
      @hunter = TalentHunter.find(params[:id])
      if @hunter.update_attributes(params[:talent_hunter])
          redirect_to admin_modules_talent_hunters_path, :notice => "El Password ha sido actualizada correctamente!"
      else
          redirect_to change_password_admin_modules_talent_hunter_path(@hunter), :notice =>"Imposible cambiar el password!"
      end
  end

  # DELETE /talent_hunters/1
  # DELETE /talent_hunters/1.json
  def destroy
    @talent_hunter = TalentHunter.find(params[:id])
    @talent_hunter.is_deleted=1
    @talent_hunter.save

    respond_to do |format|
      format.html { redirect_to admin_modules_talent_hunters_path }
      format.json { head :no_content }
    end
  end

  private
  def breadcrumb_talent
    @section_scope="Home"
    @menu_scope="settings-hunters"
  end

end
