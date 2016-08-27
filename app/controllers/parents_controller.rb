class ParentsController < ApplicationController

	before_action :require_signin, except: [:index, :show]
	before_action :require_admin, except: [:index, :show]
	before_action :set_parent, only: [:show, :edit, :update, :destroy]

	def index
#		@parents = Parent.all.order('channel_segment desc')
		@parents = Parent.all.order('corpname')
		@banners = Banner.all
		@banner_promos = BannerPromo.all
	end
	def show
	end
	def edit
	end
	def update
		if @parent.update(parent_params)
			redirect_to @parent, notice: "Parent organization successfully updated"			
		else
			render :edit
		end
	end
	def new
		@parent = Parent.new
	end
	def create		
		@parent = Parent.new(parent_params)
		if @parent.save			
			redirect_to @parent, notice: "Parent organization successfully created"			
		else
			render :new
		end
	end
	def destroy
		deleted = @parent.corpname
		@parent.destroy
		redirect_to parents_path, notice: "#{deleted} deleted"
	end
end

private
	def parent_params
		params.require(:parent).
					permit(
									:corpname, 
									:hqcity, 
									:hqstate, 
									:buyerfirstname, 
									:buyerlastname, 
									:ourbrokerfirstname, 
									:ourbrokerlastname, 
									:nextreviewdate, 
									:store_count, 
									:channel_segment, 
									:corp_notes, 
									:logo_file_name,
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