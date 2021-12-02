class Modules::PanelController < ApplicationController
  before_action :logged_admin
  layout "admins"
  add_breadcrumb :home, "/modules/panel/home"
  add_breadcrumb :settings, "/modules/panel/settings", :only=>"settings"


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
    @company=current_admin.company

    if request.post?
      
    end
  end

end