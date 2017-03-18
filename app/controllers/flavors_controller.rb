class FlavorsController < ApplicationController

	before_action :require_signin, except: [:index, :show]
	before_action :require_admin, except: [:index, :show]
	before_action :set_flavor, only: [:show, :edit, :update, :destroy] 

	def index
		@flavors = Flavor.all
	end

	def show
		@flavor = Flavor.find_by!(slug: params[:id])
end

	def edit
	end
	def update
		if @flavor.update(flavor_params)
			redirect_to @flavor, notice: "Flavor #{@flavor.shorthand} successfully updated"
		else
			render :edit
		end
	end
	def new
		@flavor = Flavor.new
	end

	def create		
		@flavor = Flavor.new(flavor_params)
		if @flavor.save			
			redirect_to @flavor, notice: "Flavor #{@flavor.shorthand} successfully created"
		else
			render :new
		end
	end
	def destroy
		deleted = @flavor.shorthand
		@flavor.destroy
		redirect_to flavors_path, notice: "#{deleted} deleted"
	end
end

private
	def flavor_params
		params.require(:flavor).
					permit(
									:shorthand, 
									:descriptor, 
									:rank, 
									:coated,
									:slug
									)
	end
	def set_flavor
		if @flavor
			@flavor = Flavor.find_by!(slug: params[:id])
		elsif params[:flavor_id].present?
			@flavor = Flavor.find_by!(slug: params[:flavor_id])
		else
			@flavor = Flavor.find_by!(slug: params[:id])
		end
	end
