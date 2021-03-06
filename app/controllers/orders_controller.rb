class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  # mount_uploader :avatar, AvatarUploader

  # GET /orders
  # GET /orders.json
  def index
    if(current_user)
       @orders = Order.where(user_id: current_user.id)
    else
      redirect_to "/users/sign_in"
    end

  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  def finsh
    @order = Order.find(params[:id])
    @order.status=0
    @order.save
    flash[:notice] = 'Order has finished and closed.'
    redirect_to '/orders/'
    # respond_to do |format|
    #   if @order.update(order_params)
    #       format.html { redirect_to :back, notice: 'Order member was successfully created.' }
    #       format.json { head :no_content}
    #     else
    #       format.html { redirect_to :back, notice: 'error in email' }
    #       format.json { head :no_content}
    #   end
    # end
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    if(current_user)
      @order = Order.new(order_params)
      # @order.avatar = params[:file] # Assign a file like this, or
      @order.user_id = current_user.id
      @order.status=1
      respond_to do |format|
        if @order.save
          format.html { redirect_to @order, notice: 'Order was successfully created.' }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to "/users/sign_in"
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
      @users = OrderMember.where(order_id: params[:id])
      @order_member = OrderMember.new
      @order_group = Group.new
      @notification = Notification.new
      # @users = Order_member.find_by order_id: params[:id]
      # @users = Order_member.all :conditions => (order_id ? ["order_id != ?", params[:id]] : [])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :resturant, :status, :user_id, :image)
    end
end
