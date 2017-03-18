class AuthorizationsController < ApplicationController

	before_action :set_parent
	before_action :set_banner
	before_action :set_authorization, only:  [:show, :edit, :update, :destroy]

	def index
		fail
	end

	def show
	end

	def new
		@authorization = @banner.authorizations.new
		@fgskus = Fgsku.where(country: @banner.country)
		@authorization.bssw = 0
	end

	def create
		fail
	end

	def edit
 #   session[:return_to] ||= request.referer
	end

	def update
		@authorization = @banner.authorizations.find(params[:id])
		if @authorization.update(authorization_params)
#			redirect_to :back
#			redirect_to session.delete(:return_to), notice: "authorization updated"
			redirect_to parent_banner_path(@parent, @banner), notice: "authorization updated"
		else
			render :edit
		end
	end

end

private
	def authorization_params
		params.require(:authorization).permit(
																	:banner_id,
																	:fgsku_id,
																	:authdate,
																	:dropdate,
																	:bssw
																	)
	end

	def set_banner
		if @authorization
			@authorization.banner
		elsif params[:banner_id].present?
			@banner = Banner.find_by!(slug: params[:banner_id])
		else
			@banner = Banner.find_by!(slug: params[:id])
		end
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

	def set_authorization
		@authorization = Authorization.find(params[:id])
	end