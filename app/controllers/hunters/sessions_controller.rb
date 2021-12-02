class Hunters::SessionsController < Devise::SessionsController
   
   #def new
   #	@btn_active='login'
   #	render :layout=>"home"
   #end

   def new
      super
   end

   def create
      logger.info "Attempt to sign in by #{ params[:talent_hunter][:email] }"
      super
   end

   def destroy
      logger.info "#{ current_talent_hunter.email } signed out"
      super
   end

   #def destroy
   #   super
   #end
      
end