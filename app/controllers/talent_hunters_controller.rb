class TalentHuntersController < ApplicationController
  before_action :logged_root_admin
  add_breadcrumb :panel, "/settings/index"
  add_breadcrumb :data, "/settings/data"
  add_breadcrumb :home, :countries_path
  add_breadcrumb :new, :new_company_path, :only=>['new','create']
  add_breadcrumb :edit, :new_company_path, :only=>['edit','update']
  add_breadcrumb :show, :company_path, :only=>['show','countries','admins']
  add_breadcrumb :countries, "/settings/countries", :only=>['countries']
  add_breadcrumb :admins, "/settings/admins", :only=>['admins']
  layout "admins"

  # GET /talent_hunters
  # GET /talent_hunters.json
  def index
    @url="/panel/settings"
    @countries=Country.all
    @companies=Company.all(:conditions=>["is_deleted=?",false])
    conditions = [" "]
    conditions[0]+=" is_deleted = ? "
    conditions << false

    if params[:country_id] and !params[:country_id]=='all'
      conditions[0]+=" AND country_id = ? "
      conditions << params[:country_id]
    end
    if params[:company_id] and !params[:company_id]=='all'
      conditions[0]+=" AND company_id = ? "
      conditions << params[:company_id]
    end

    @talent_hunters = TalentHunter.paginate(:conditions=>conditions,:page=>params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @talent_hunters }
    end
  end

  # GET /talent_hunters/1
  # GET /talent_hunters/1.json
  def show
    @url="/panel/settings"
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

    respond_to do |format|
      if @talent_hunter.save
        format.html { redirect_to @talent_hunter, notice: 'Talent hunter was successfully created.' }
        format.json { render json: @talent_hunter, status: :created, location: @talent_hunter }
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
        format.html { redirect_to @talent_hunter, notice: 'Talent hunter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @talent_hunter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /talent_hunters/1
  # DELETE /talent_hunters/1.json
  def destroy
    @talent_hunter = TalentHunter.find(params[:id])
    @talent_hunter.destroy

    respond_to do |format|
      format.html { redirect_to talent_hunters_url }
      format.json { head :no_content }
    end
  end
end
