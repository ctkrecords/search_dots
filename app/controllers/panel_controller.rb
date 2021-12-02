class PanelController < ApplicationController
  #before_filter :logged_admin, :except=>"index"
  before_action :logged_admin, :except=>"index"
  add_breadcrumb :settings, "/panel/settings", :only=>['settings']
  add_breadcrumb :index, "/panel/home", :only=>['home']
  layout "admins"
  def index
  	render :layout=> 'home'
  end

  def home
  	@url="/panel/home"
  end

  def settings
  	@url="/panel/settings"
  end
end
