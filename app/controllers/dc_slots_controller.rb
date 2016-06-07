class DcSlotsController < ApplicationController

	before_action :set_distributor
	before_action :set_dc

	def index
		fail
	end

	def show
		@dc_slot = DcSlot.find(params[:id])
	end

	def new
		@dc_slot = @banner.dc_slots.new
		@fgskus = Fgsku.where(country: @banner.country)
	end

	def create
		fail
	end

	def edit
		@dc_slot = DcSlot.find(params[:id])
	end

	def update
		@dc_slot = @banner.dc_slots.find(params[:id])
		if @dc_slot.update(dc_slot_params)
			redirect_to distributor_dc_path(@distributor, @dc), notice: "slot successfully updated"			
		else
			render :edit
		end
	end

end

private
	def dc_slot_params
		params.require(:dc_slot).permit(
																	:dc_id,
																	:fgsku_id,
																	:authdate,
																	:dropdate
																	)
	end

	def set_dc
		@dc = Dc.find_by!(slug: params[:dc_id])
	end

	def set_distributor
		if @dc
			@distributor = @dc.distributor
		else
			@distributor = Distributor.find_by!(slug: params[:distributor_id])
		end
	end
