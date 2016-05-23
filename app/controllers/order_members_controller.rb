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
      if group =  Group.find_by(name: params[:group])
         # group =  Group.find_by(name: params[:group])

        @group_users = GroupMember.where(group_id: group.id.to_s)
        for users in @group_users do
          @order_member = OrderMember.new(order_member_params)
          @order_member.user_id=users.user_id.to_s
          @order_member.status_user=0 
          @order_member.save          
          # abort(users.user_id.to_s)
        end       
      else
      end


      if @friend =  User.find_by(email: params[:email])
        # @friend=User.where("email = "+params[:email])
        # print "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\n aa";
        # print params[:order_id];
        @order_member = OrderMember.new(order_member_params)
        # @order_member.order_id=params[:order_id]
        @order_member.user_id=@friend.id
        @order_member.status_user=0	
        respond_to do |format|

        if @order_member.save
            @notify = Notification.new
            @notify.user_id= current_user.id
            @notify.content = ' has add '+@friend.name+'  "'+@order_member.order.name+'"'
            @notify.url = "/orders/"+@order_member.order_id.to_s+"/order_details"
            @notify.save
          format.html { redirect_to :back, notice: 'Order member was successfully created.' }
          format.json { head :no_content}
        else
          format.html { redirect_to :back, notice: 'error in email' }
          format.json { head :no_content}
        end
      end
    else
        respond_to do |format|
            format.html { redirect_to :back, notice: 'error in email' }
        end
    end
    # @order_member = OrderMember.new(order_member_params)

    # respond_to do |format|
    #   if @order_member.save
    #     format.html { redirect_to @order_member, notice: 'Order member was successfully created.' }
    #     format.json { render :show, status: :created, location: @order_member }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @order_member.errors, status: :unprocessable_entity }
    #   end
    # end
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
      format.html { redirect_to :back, notice: 'Order member was successfully destroyed.' }
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

    def notification_params
      params.require(:notification).permit(:user_id, :content, :status)
    end


end
