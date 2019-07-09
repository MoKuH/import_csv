class ApplicationController < ActionController::Base

	def destroy
		if User.destroy_all
			flash[:success]=  "All users have been deleted"
		else
			flash[:error]= "Cant delete all users"
		end
		redirect_to users_path
	end

end
