class UsersController < ApplicationController

	before_action :require_signin, except: [:new, :create]
	before_action :require_correct_user, only: [:edit, :update, :destroy]

	def new
		@user = User.new # for SSL on custom domain name at Heroku, see https://devcenter.heroku.com/articles/ssl-endpoint 
	end

	def create
		@user = User.new(user_params)
		if @user.save
				session[:user_id]	= @user.id  # auto login when create account
			redirect_to @user, notice: "New user #{@user.name} successfully created"			
		else
			render :new
		end
	end

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
	end

	def update
		if @user.update(user_params)			
			redirect_to @user, notice: "New user #{@user.name} successfully updated"			
		else
			render :edit
		end
	end

	def destroy
		deleted = @user.name
		@user.destroy
		session[:user_id] = nil
		redirect_to root_path, notice: "#{deleted} deleted"
	end

end

private

	def require_correct_user
		@user = User.find(params[:id])
		unless current_user?(@user)
			redirect_to root_path, notice: "You can't do that"
		end

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	end
