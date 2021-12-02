class Users::SessionsController < Devise::SessionsController
 
#def new
# 	@btn_active='login'
#   render :layout=>"home"
#end

def new
   super
end

 def create
    logger.info "Attempt to sign in by #{ params[:admin][:email] }"
    super
 end

 def destroy
    logger.info "#{ current_admin.email } signed out"
    super
 end
 	
end