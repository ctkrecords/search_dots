class Hunters::PasswordsController < Devise::PasswordsController
	def new
 		render :layout=>"home"
 	end
 	def edit
 	end
end