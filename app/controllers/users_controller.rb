class UsersController < ApplicationController

	before_action :set_user, only:[:show,:destroy,:update,:edit]

	#handle exception raise rails strong parameter if the front validation is not working
	rescue_from ActionController::ParameterMissing do |e|
		flash[:error]="some mandatory parameters are missing"
		redirect_to root_path
	end

	#handle exception raise by the importer module
	rescue_from Importer::InvalidFormat do |e|
		flash[:error]=e.message
		redirect_to new_user_path
	end

	#GET - index method, return html with all users, or a file
	def index
		@users= User.all
		respond_to do |format|
			format.html
			format.csv { send_data Importer.generate(:csv, @users), filename: "users-#{Date.today}.csv" }
		end

	end

	#GET - new method, display the bulk user import form
	def new
		@user = User.new
	end


	#GET users/:id, show method, display the user by id
	def show

	end

	#DELETE users/:id, destroy method , delete the user by id
	def destroy
		if @user.destroy
			redirect_to users_path, flash: {success: "User deleted successfully"}
		else
			flash[:error]="User cannot be deleted"
			render :show
		end
	end

	#POST users, create method, import the users file
	# Use an importer to easily add other supported file format
	def create
		result = Importer.import(User,users_import_params)
		if result.success?
			redirect_to users_path, flash: {success: "Users imported successfully"}
		else
			flash[:error] = "error during users import, #{result.total_failed}/#{result.total_entries} user(s) not imported"
			redirect_to users_path
		end

	end

	#PATCH users/:id, update method , update the user with the authorized params
	def update
		if @user.update(users_params)
			redirect_to users_path, flash: {success: "User edited successfully"}
		else
			flash[:error]="User cannot be edited"
			render :edit
		end
	end


	private

	def set_user
		@user = User.where(id: params[:id]).first
		redirect_to users_path, flash: {notice: "user not found"} if @user.nil?
	end

	#strong parameters for update method
	def users_params
		params.require(:user).permit(:name,:number,:date,:description)
	end

	#strong parameters for create method
	def users_import_params
		params.require(:user).require(:file_csv)
	end
end
