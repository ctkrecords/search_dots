class AdminsController < ApplicationController
  before_action :logged_root_admin, :except=>"my_profile"
  add_breadcrumb :panel, "/settings/index"
  add_breadcrumb :data, "/settings/data"
  add_breadcrumb :home, :admins_path
  add_breadcrumb :new, :new_admin_path, :only=>['new','create']
  add_breadcrumb :edit, :new_admin_path, :only=>['edit','update','change_password_user']
  add_breadcrumb :show, :admins_path, :only=>['show']
  layout "admins"

    
  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.paginate(:conditions=>["is_deleted=? and id not in (?)",false,current_admin.id],:page => params[:page])

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
    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
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

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
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
        format.html { redirect_to "/my_profile", notice: 'Admin was successfully updated.' }
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
          redirect_to "/my_profile", :notice => "Tu Password ha sido actualizada correctamente!"
      else
          redirect_to "/my_password", :notice =>"Imposible cambiar su password!"
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

  def password_user
    if request.post?
      @admin = Admin.find(params[:id])
      if @admin.update_attributes(params[:admin])
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
      @admin = Admin.find(params[:id])
      respond_to do |format|
        format.html { render :password_user}
        format.json { render :password_user, json: @admin }
      end
    end
  end

end
