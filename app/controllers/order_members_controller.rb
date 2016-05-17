class OrderMembersController < ApplicationController
  before_action :set_order_member, only: [:show, :edit, :update, :destroy]

  # GET /order_members
  # GET /order_members.json
  def index
    @order_members = OrderMember.all
  end

  # GET /order_members/1
  # GET /order_members/1.json
  def show
  end

  # GET /order_members/new
  def new
    @order_member = OrderMember.new
  end

  # GET /order_members/1/edit
  def edit
  end

  # POST /order_members
  # POST /order_members.json
  def create
    @order_member = OrderMember.new(order_member_params)

    respond_to do |format|
      if @order_member.save
        format.html { redirect_to @order_member, notice: 'Order member was successfully created.' }
        format.json { render :show, status: :created, location: @order_member }
      else
        format.html { render :new }
        format.json { render json: @order_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_members/1
  # PATCH/PUT /order_members/1.json
  def update
    respond_to do |format|
      if @order_member.update(order_member_params)
        format.html { redirect_to @order_member, notice: 'Order member was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_member }
      else
        format.html { render :edit }
        format.json { render json: @order_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_members/1
  # DELETE /order_members/1.json
  def destroy
    @order_member.destroy
    respond_to do |format|
      format.html { redirect_to order_members_url, notice: 'Order member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_member
      @order_member = OrderMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_member_params
      params.require(:order_member).permit(:order_id, :user_id, :status_user)
    end
end
