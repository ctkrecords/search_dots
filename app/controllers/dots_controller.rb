class DotsController < ApplicationController
  before_action :logged_admin
  add_breadcrumb :settings, "/panel/settings"
  add_breadcrumb :home, :dots_path
  add_breadcrumb :new, :new_dot_path, :only=>['new','create']
  add_breadcrumb :edit, :new_dot_path, :only=>['edit','update']
  add_breadcrumb :show, :dot_path, :only=>['show']
  layout "admins"
  # GET /dots
  # GET /dots.json
  def index
    @url="/panel/settings"
    @dots = Dot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dots }
    end
  end

  # GET /dots/1
  # GET /dots/1.json
  def show
    @url="/panel/settings"
    @dot = Dot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dot }
    end
  end

  # GET /dots/new
  # GET /dots/new.json
  def new
    @url="/panel/settings"
    @dot = Dot.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dot }
    end
  end

  # GET /dots/1/edit
  def edit
    @url="/panel/settings"
    @dot = Dot.find(params[:id])
  end

  # POST /dots
  # POST /dots.json
  def create
    @dot = Dot.new(params[:dot])

    respond_to do |format|
      if @dot.save
        format.html { redirect_to @dot, notice: 'Dot was successfully created.' }
        format.json { render json: @dot, status: :created, location: @dot }
      else
        format.html { render action: "new" }
        format.json { render json: @dot.errors, status: :unprocessable_entity }
      end
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

  # DELETE /dots/1
  # DELETE /dots/1.json
  def destroy
    @dot = Dot.find(params[:id])
    @dot.destroy

    respond_to do |format|
      format.html { redirect_to dots_url }
      format.json { head :no_content }
    end
  end
end
