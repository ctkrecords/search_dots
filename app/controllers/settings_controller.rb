class SettingsController < ApplicationController
  before_action :logged_root_admin
  layout "admins"
  add_breadcrumb :home, "/settings/index"
  add_breadcrumb :data, "/settings/data", :only=>['data']
  
  def index
  	@menu_scope="home"
  end

  def data
  	@url="/settings/data"
  end

end