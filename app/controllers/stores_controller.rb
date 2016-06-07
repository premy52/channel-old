class StoresController < ApplicationController

	before_action :set_parent
	before_action :set_banner
	before_action :set_store, only: [:show, :edit, :update, :destroy] 

	def index		
	end

	def show
	end

	def edit
	end

	def update
		if @store.update(store_params)
			redirect_to parent_banner_store_path, notice: "Store successfully updated"			
		else
			render :edit
		end
	end

	def new
		@store = @banner.stores.new
	end

	def create
		@store = @banner.stores.new(store_params)
		if @store.save
			redirect_to parent_banner_path(@banner.parent, @banner), notice: "New store in #{@store.city}, #{@store.state} created"
		else
			render :new
		end
	end

	def destroy
		deleted = @store.store_name
		@store.destroy
		redirect_to parent_banner_stores_path, notice: "#{deleted} store deleted"
	end

end

private
	def store_params
				params.require(:store).permit(
							:street_address,
							:city,
							:state,
							:zip,
							:dc_id,
							:store_name,
							:slug
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
		if @store
			@banner = @store.banner
		elsif params[:banner_id].present?
			@banner = Banner.find_by!(slug: params[:banner_id])
		else
			@banner = Banner.find_by!(slug: params[:id])
		end
	end

	def set_store
		@store = Store.find_by!(slug: params[:id])
	end