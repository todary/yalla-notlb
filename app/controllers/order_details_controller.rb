class OrderDetailsController < ApplicationController
  before_action :set_order_detail, only: [:show, :edit, :update, :destroy]

  # GET /order_details
  # GET /order_details.json
  def index
     @order_details = OrderDetail.where("order_id = ?", params[:order_id])
    # @order_details = OrderDetail.all
  end

  # GET /order_details/1
  # GET /order_details/1.json
  def show
    @order_detail = OrderDetail.find(params[:id])
    if request.xhr?
    respond_to do |format|
        format.html {render :partial => 'modal'}
        format.json {head :ok}
    end
  end
  end

  # GET /order_details/new
  def new
    @order_detail = OrderDetail.new
  end

  # GET /order_details/1/edit
  def edit
  end

  # POST /order_details
  # POST /order_details.json
  def create
    @order_detail = OrderDetail.new(order_detail_params)
    respond_to do |format|
      if @order_detail.save
        format.html { redirect_to order_order_details_url, notice: 'Order detail was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @order_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_details/1
  # PATCH/PUT /order_details/1.json
  def update
    respond_to do |format|
      if @order_detail.update(order_detail_params)
        format.html {render :show, notice: 'Order detail was successfully updated.' }
         format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @order_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_details/1
  # DELETE /order_details/1.json
  def destroy
    @order_detail.destroy
    respond_to do |format|
      format.html { redirect_to order_details_url, notice: 'Order detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_detail
      @order_detail = OrderDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_detail_params
      params.require(:order_detail).permit(:item, :amount, :price, :comment, :order_id, :user_id)
    end
end
