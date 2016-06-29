class DcsController < ApplicationController

	before_action :set_distributor
	before_action :set_dc, only: [:show, :edit, :update, :destroy]

	def index
		@dcs = @distributor.dcs
	end
	
	def show
		@dc = Dc.find_by(slug: params[:id])
	end
	
	def edit
#		@dc = @distributor.dcs.find(params[:id])
	end
	
	def update
#		@dc = @distributor.dcs.find(params[:id])
		if @dc.update(dc_params)
			redirect_to distributor_dc_path, notice: "DC successfully updated"			
		else
			render :edit
		end
	end
	
	def new
		@dc = @distributor.dcs.new
	end
	
	def create
		@dc = @distributor.dcs.new(dc_params)
		if @dc.save
			redirect_to distributor_dcs_path(@distributor), notice: "New retail DC #{@dc.dc_name} created"
		else
			render :new
		end
	end
	
	def destroy
#		@dc = @distributor.dcs.find(params[:id])
		deleted = @dc.dc_name
		@dc.destroy
		redirect_to distributor_dcs_path, notice: "#{deleted} deleted"
	end

end

private	
	def dc_params
		params.require(:dc).permit(
																:dc_name,
																:dc_contact_first_name,
																:dc_contact_last_name,
																:dc_contact_email,
																:dc_contact_phone,
																:dc_address_1,
																:dc_address_2,
																:dc_city,
																:dc_state,
																:dc_zip,
																:dc_notes,
																:country,
																:listprice,
																:slug,
																slotted_fgsku_ids: []
																)
  end

	def set_distributor
		if @dc
			@distributor = @dc.distributor
		elsif params[:distributor_id].present?
			@distributor = Distributor.find_by!(slug: params[:distributor_id])
		else
			@distributor = Distributor.find_by!(slug: params[:id])
		end
	end

	def set_dc
#		parameter = :dc_id || :id
		@dc = Dc.find_by(slug: params[:id])
	end