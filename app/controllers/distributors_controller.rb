class DistributorsController < ApplicationController

	before_action :set_distributor, only: [:show, :edit, :update, :destroy]

	def index
		 case params[:coverage]
		 	when "current"
				@banners = Banner.current_banners
				@dcs = Dc.dcs_with_current_banners
				@distributors = Distributor.distributors_with_current_banners
		 	when "prospect"
				@banners = Banner.prospect_banners
				@dcs = Dc.dcs_with_prospect_banners
				@distributors = Distributor.distributors_with_prospect_banners
		 	when "priority"
				@banners = Banner.priority_banners
				@dcs = Dc.all.order("dc_name")
				@distributors = Distributor.all.order("distributor_name")
		 	when "no_banners"
		 		@banners = nil
				@dcs = Dc.all.order("dc_name")
				@distributors = Distributor.all.order("distributor_name")
		 	else
				@banners = Banner.all_banners
				@dcs = Dc.all.order("dc_name")
				@distributors = Distributor.all.order("distributor_name")
			end
		@authorizations = Authorization.all.includes(:fgsku).order("fgskus.sizegroup")
		@dc_slots = DcSlot.all.includes(:fgsku).order("fgskus.sizegroup")
		@ranked_flavors = Flavor.ranked_flavors
	end

	def show
	end

	def edit
	end

	def update
		if @distributor.update(distributor_params)
			redirect_to @distributor, notice: "Distributor successfully updated"			
		else
			render :edit
		end		
	end

	def new
		@distributor = Distributor.new
	end

	def create
		@distributor = Distributor.new(distributor_params)
		if @distributor.save			
			redirect_to @distributor, notice: "Distributor successfully created"			
		else
			render :new
		end
	end

	def destroy
		deleted = @distributor.distributor_name
		@distributor.destroy
		redirect_to distributors_path, notice: "#{deleted} deleted"
	end

end

private
	def distributor_params
		params.require(:distributor).permit(  :distributor_name, 
																			    :distributor_contact_first_name,
																			    :distributor_contact_last_name,
																			    :distributor_contact_email,
																			    :distributor_contact_phone,
																			    :distributor_address_1,
																			    :distributor_address_2,
																			    :distributor_city,
																			    :distributor_state,
																			    :distributor_zip,
																			    :distributor_notes,
																			    :channel_segment,
																			    :country,
																					:slug 
																					)
	end

	def set_distributor
#		parameter = :distributor_id || :id
		@distributor = Distributor.find_by!(slug: params[:id])
	end
