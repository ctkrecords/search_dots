# encoding: utf-8
class ApplicationController < ActionController::Base
  
  protect_from_forgery
  #before_filter :set_tem_dates
  before_action :set_tem_dates
  
  def set_tem_dates
    # @current_year="2016"
    #@current_year=ENV['CURRENT_YEAR']
    
      if params[:year]

         session[:year]=params[:year]

      else
        session[:year]=Time.zone.now.year.to_s if session[:year].nil?

      end
    @years=WorkCalendar.select(:year).where(:country_id => current_admin.country_id) if admin_signed_in?
    @current_year = session[:year] 

    if Date.today.strftime("%U").to_i == 0
      @current_week=1
    else
      @current_week=Date.today.strftime("%U").to_i 
    end

  end

  def logged_root_admin
    if !admin_signed_in?
      redirect_to "/admin", :notice => "Necesitas estar logeado para ingresar"
    elsif admin_signed_in? and !current_admin.is_root
      redirect_to "/admin_modules/panel/home", :notice => "No tines los permisos necesarios"
    end
  end
  
  def logged_company_admin
     if !admin_signed_in?
      redirect_to "/admin", :notice => "Necesitas estar logeado para ingresar"
    elsif admin_signed_in? and (!current_admin.is_company_admin)
      redirect_to "/modules/dots/index", :notice => "No tines los permisos necesarios"
    end
  end

  def logged_admin
    if !admin_signed_in?
      redirect_to "/admin", :notice => "Necesitas estar logeado para ingresar"
    end   
  end

  def logged_hunter
    if !talent_hunter_signed_in?
      redirect_to "/login", :notice => "Necesitas estar logeado para ingresar"
    end
  end

  def after_sign_out_path_for(resource_or_scope)
      root_path
  end

  def after_sign_in_path_for(resource_or_scope)
      session[:side_menu_status]=true
      if resource_or_scope.class== Admin
        if current_admin.is_root
          "/settings/index"
        elsif current_admin.is_company_admin
          "/admin_modules/panel/home"
        elsif current_admin.is_country_admin
          "/modules/panel/home"
        end
      elsif resource_or_scope.class == TalentHunter
        hunter_home_path
      else
        "/hunter"
      end
  end

end
