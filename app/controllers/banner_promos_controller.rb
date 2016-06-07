class BannerPromosController < ApplicationController

	before_action :set_banner
	before_action :set_parent
	before_action :set_promo, only: [:show, :edit, :update, :destroy] 

	def index
		fail
	end

	def show
	end

	def edit
	end

	def update
		if @banner_promo.update(promo_params)
			redirect_to parent_banner_banner_promo_path, notice: "Promo updated"
		else
			render :edit
		end
	end

	def new
		@banner_promo = @banner.banner_promos.new
	end

	def create
		@banner_promo = @banner.banner_promos.new(promo_params)
		if @banner_promo.save
			redirect_to parent_banner_path(@banner.parent, @banner), notice: "Created #{@banner_promo.promo_vehicle} #{@banner_promo.promo_method} of #{@banner_promo.promo_level} from #{@banner_promo.start_date} to #{@banner_promo.end_date}"
		else
			render :new
		end
	end

	def destroy
		deleted = @banner_promo.comment
		@banner_promo.destroy
		redirect_to parent_banner_stores_path, notice: "#{deleted} promotion deleted"
	end

end

private
	def promo_params
		params.require(:banner_promo).permit(
			   	:start_date, 
			   	:end_date, 
			   	:promo_vehicle, 
			   	:promo_method, 
			   	:promo_level, 
			   	:status, 
			   	:comment, 
			   	:banner_id
					)
	end

		def set_banner
		if @banner
			@banner = Banner.find_by!(slug: params[:id])
		elsif params[:banner_id].present?
			@banner = Banner.find_by!(slug: params[:banner_id])
		else
			@banner = Banner.find_by!(slug: params[:id])
		end

	# def set_banner
	# 	parameter = :banner_id || :id
	# 	@banner = Banner.find_by!(slug: params[parameter])
	# end
	def set_parent
		if @banner
			@parent = @banner.parent
		elsif params[:parent_id].present?
			@parent = Parent.find_by!(slug: params[:parent_id])	
		else
			@parent = Parent.find_by!(slug: params[:id])
		end
	end
	def set_promo
		@banner_promo = BannerPromo.find(params[:id])
	end

