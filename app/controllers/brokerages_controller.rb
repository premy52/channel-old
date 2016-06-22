class BrokeragesController < ApplicationController
  before_action :set_brokerage, only: [:show, :edit, :update, :destroy]

  # GET /brokerages
  # GET /brokerages.json
  def index
    @brokerages = Brokerage.all
  end

  # GET /brokerages/1
  # GET /brokerages/1.json
  def show
  end

  # GET /brokerages/new
  def new
    @brokerage = Brokerage.new
  end

  # GET /brokerages/1/edit
  def edit
  end

  # POST /brokerages
  # POST /brokerages.json
  def create
    @brokerage = Brokerage.new(brokerage_params)

    respond_to do |format|
      if @brokerage.save
        format.html { redirect_to @brokerage, notice: 'Brokerage was successfully created.' }
        format.json { render :show, status: :created, location: @brokerage }
      else
        format.html { render :new }
        format.json { render json: @brokerage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /brokerages/1
  # PATCH/PUT /brokerages/1.json
  def update
    respond_to do |format|
      if @brokerage.update(brokerage_params)
        format.html { redirect_to @brokerage, notice: 'Brokerage was successfully updated.' }
        format.json { render :show, status: :ok, location: @brokerage }
      else
        format.html { render :edit }
        format.json { render json: @brokerage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brokerages/1
  # DELETE /brokerages/1.json
  def destroy
    @brokerage.destroy
    respond_to do |format|
      format.html { redirect_to brokerages_url, notice: 'Brokerage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brokerage
      @brokerage = Brokerage.find_by!(slug: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brokerage_params
      params.require(:brokerage).permit(
                                        :company, 
                                        :address1, 
                                        :address2, 
                                        :city, 
                                        :state, 
                                        :zip, 
                                        :rate,
                                        :slug
                                        )
    end
end
