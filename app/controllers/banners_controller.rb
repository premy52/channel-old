class BannersController < ApplicationController

	before_action :set_parent
	before_action :set_banner, only: [:show, :update, :edit, :destroy]

	def index
		@banners = @parent.banners
	end
	
	def show
		@banner = Banner.find_by!(slug: params[:id])
	end
	
	def edit		
	end
	
	def update
		if @banner.update(banner_params)
			redirect_to parent_banner_path, notice: 'Banner successfully updated'
		else
			render :edit
		end
	end
	
	def new
		@banner = @parent.banners.new
	end
	
	def create
		@banner = @parent.banners.new(banner_params)
		if @banner.save
			redirect_to parent_banners_path(@parent), notice: "New retail banner #{@banner.banner_name} created"
		else
			render :new
		end
	end
	
	def destroy
		deleted = @banner.banner_name
		@banner.destroy
		redirect_to parent_banners_path, notice: "#{deleted} deleted"
	end

end

private
	def banner_params
				params.require(:banner).permit(
							:banner_name,
							:banner_city,
							:banner_state,
							:banner_buyer_first_name,
							:banner_buyer_last_name,
							:banner_broker_first_name,
							:banner_broker_last_name,
							:banner_review_date,
							:banner_store_count,
							:our_banner_store_count,
							:banner_notes,
							:logo_file_name,
							:country,
							:dc_id,
							:priority,
							:slug,
							:broker_id,
							:bar_regular_retail,
							:caddy_actual_cost,
							:bar_feature_price,
							:performance,
							authorized_fgsku_ids: []
							)
	end
	def set_parent
		if @banner
			@parent = @banner.parent
		elsif params[:parent_id].present?
			@parent = Parent.find_by!(slug: params[:parent_id])
		else 
			@parent = Parent.find_by!(slug: params[:id])
		end
	end

	def set_banner
		if @banner
			@banner = Banner.find_by!(slug: params[:id])
		elsif params[:banner_id].present?
			@banner = Banner.find_by!(slug: params[:banner_id])
		else
			@banner = Banner.find_by!(slug: params[:id])
		end

	end
