# encoding: utf-8
class CompaniesController < ApplicationController
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
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all(:conditions=>["is_deleted=?",false])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  def countries
    @companies_menu="company-countries"
    @company = Company.find(params[:id])
    @countries = @company.countries.all(:conditions=>["is_deleted=?",false])
    
  end

  def assing_country_to
    @companies_menu="company-countries"
    @company=Company.find(params[:id])

    if request.post?
        if params[:new_company_country]
          params[:new_company_country][:countries].each do |country|
            unless country.blank?
              new_company_country_for = CompaniesCountry.new
              new_company_country_for.company_id=@company.id
              new_company_country_for.country_id=country
              if new_company_country_for.save
                flash[:notice] = "País(es) asignado(s) correctamente"
              else
                flash[:notice] = "Error al intertar Agregar"
              end
             end
          end
        end
    end
    redirect_to "/companies/countries/#{@company.id}"
  end

  def delete_country_from
    if params[:country] and params[:id]
      country=CompaniesCountry.find(:first, :conditions=>["country_id=? and company_id=?",params[:country],params[:id]])
      country.is_deleted=true
      country.save
      flash[:notice]="País removido"
    else
      flash[:notice]="Error al remover el país"
    end
      redirect_to "/companies/countries/#{params[:id]}"
  end

  def admins
    @companies_menu="company-admins"
    @company = Company.find(params[:id])
    @unassigned_admins = Admin.find(:all, :conditions=>["company_id=?",@company.id])
    
  end

  def edit_admin
    @admin = Admin.find(params[:id])
  end

  def update_admin
    @admin = Admin.find(params[:id])
    
    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to "/companies/admins/#{@admin.company_id}", notice: 'Admin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to "/companies/admins/#{@admin.company_id}" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @companies_menu="company"
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.is_deleted=true
    @company.save
    #@company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
end
