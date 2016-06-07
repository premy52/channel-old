class FgskusController < ApplicationController

	before_action :set_flavor 
	before_action :set_fgsku, only: [:show, :edit, :update, :destroy] 

	def index
		@fgskus = @flavor.fgskus
	end

	def show
		@authorizing_banners = @fgsku.authorizing_banners
	end

	def edit
	end

	def update
		if @fgsku.update(fgsku_params)
			redirect_to flavor_fgskus_path, notice: "SKU #{@fgsku.weightoz} oz. #{@fgsku.flavor.shorthand} #{@fgsku.sizegroup} #{@fgsku.country} successfully updated"
		else
			render :edit
		end
	end

	def new
		@fgsku = @flavor.fgskus.new
	end

	def create
		@fgsku = @flavor.fgskus.new(fgsku_params)
		if @fgsku.save
			redirect_to flavor_fgskus_path, notice: "New SKU #{@fgsku.weightoz} oz. #{@fgsku.flavor.shorthand} #{@fgsku.sizegroup} successfully created"
		else
			render :new
		end
	end

	def destroy
		deleted = "#{@fgsku.weightoz} oz. #{@fgsku.flavor.shorthand} #{@fgsku.sizegroup}"
		@fgsku.destroy
		redirect_to flavors_path, notice: "SKU #{deleted} deleted"
	end

end

private
	def fgsku_params
		params.require(:fgsku).permit(
					:flavor_id,
					:sizegroup,
					:weightoz,
					:innercount,
					:outercount,
					:upc,
					:innerupc,
					:outerupc,
					:country,
					:comment
					)
	end
	def set_flavor
		if @fgsku 
			@flavor = @fgsku.flavor
		else 
			parameter = :flavor_id || :id
			@flavor = Flavor.find_by(slug: params[parameter])
		end
	end
	def set_fgsku
		@fgsku = Fgsku.find_by!(params[:id])
	end
