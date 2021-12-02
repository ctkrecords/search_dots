class AdminModules::AdminsController < ApplicationController
  before_action :logged_company_admin
  before_action :breadcrumb_admin
  layout "admins"
  add_breadcrumb :index, "/admin_modules/panel/home"
  add_breadcrumb :settings, "/admin_modules/panel/settings"
  add_breadcrumb :home, "/admin_modules/panel/admins/index"

  def index
    #original @admins = Admin.paginate(:conditions=>["is_deleted=? and admin_type_id <> 1 and company_id=? and id not in (?)",false,current_admin.company_id,current_admin.id],:page => params[:page])
    @admins = Admin.where("is_deleted=? and admin_type_id <> 1 and company_id=? and id not in (?)", false, current_admin.company_id, current_admin.id).paginate(:page => params[:page]).order('last_sign_in_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admins }
    end
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
    @admin = Admin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin }
    end
  end

  # GET /admins/new
  # GET /admins/new.json
  def new
    @admin = Admin.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin }
    end
  end

  # GET /admins/1/edit
  def edit
    @admin = Admin.find(params[:id])
  end

  # GET /admins/1/edit_profile
  def edit_profile
    @admin = Admin.find(params[:id])
  end


  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(params[:admin])
    @admin.company_id=current_admin.company_id
    respond_to do |format|
      if @admin.save
        format.html { redirect_to admin_modules_admins_path, notice: 'Admin was successfully created.' }
        format.json { render json: @admin, status: :created, location: @admin }
      else
        format.html { render action: "new" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admins/1
  # PUT /admins/1.json
  def update
    @admin = Admin.find(params[:id])
    @admin.company_id=current_admin.company_id
    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to admin_modules_admins_path, notice: 'Admin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admins/1
  # PUT /admins/1.json
  def update_profile
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to "/admin_modules/my_profile", notice: 'Admin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit_profile", notice: 'errors' }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin = Admin.find(params[:id])
    @admin.is_deleted=true

    @admin.save
    #@admin.destroy

    respond_to do |format|
      format.html { redirect_to admins_url }
      format.json { head :no_content }
    end
  end
  
  def profile
    @admin = Admin.find(current_admin.id)

    respond_to do |format|
      format.html { render :profile}
    end
  end

  def password
    @admin = Admin.find(current_admin.id)
    if request.post?
      if @admin.update_with_password(params[:admin])
          sign_in(@admin, :bypass => true)
          redirect_to "/admins/#{@admin.id}", :notice => "Tu Password ha sido actualizada correctamente!"
      else
          redirect_to "/admins/#{@admin.id}", :notice =>"Imposible cambiar su password!"
      end
      # if @admin.password==params[:admin][:admin_current_password]
      #   render :inline=>"Si"
      # else
      #   redirect_to "/change_password", :notice=>"La contraseña actual no coincide"
      # end
    else
      respond_to do |format|
        format.html { render :password}
        format.json { render :password, json: @admin }
      end
    end
  end

  def my_password
    @admin = Admin.find(current_admin.id)
    if request.post?
      if @admin.update_with_password(params[:admin])
          sign_in(@admin, :bypass => true)
          redirect_to "/admin_modules/my_profile", :notice => "Tu Password ha sido actualizada correctamente!"
      else
          redirect_to "/admin_modules/my_password", :notice =>"Imposible cambiar su password!"
      end
      # if @admin.password==params[:admin][:admin_current_password]
      #   render :inline=>"Si"
      # else
      #   redirect_to "/change_password", :notice=>"La contraseña actual no coincide"
      # end
    else
      respond_to do |format|
        format.html { render :my_password}
        format.json { render :my_password, json: @admin }
      end
    end
  end

  def edit_password_admin
    @admin = Admin.find(params[:id])
    respond_to do |format|
      format.html { render :password_user}
      format.json { render :password_user, json: @admin }
    end
  end

  def update_password_admin
      @admin = Admin.find(params[:id])
      if @admin.update_attributes(params[:admin])
          redirect_to admin_modules_admins_path, :notice => "Tu Password ha sido actualizada correctamente!"
      else
          redirect_to change_admin_password_path(@admin), :notice =>"Imposible cambiar su password!"
      end
  end

  private
  def breadcrumb_admin
    @section_scope="Home"
    @menu_scope="settings-admins"
  end

end