class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    if(current_user)
      @groups = Group.all
    else
      redirect_to "/users/sign_in"
    end
    
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    # @members = GroupMember.find(@user.id, :include => :comments)
    @members = GroupMember.where( 'group_id = '+params[:id]).pluck(:user_id)
    @friends_of_user = []
    for userFriend in current_user.friend1 do
      @friends_of_user << User.where('id IN (?)',userFriend.friend_id).pluck(:id)
    end
    if(@members.count > 0)
      @friend_users = User.where('id IN (?)',@friends_of_user.map(&:first)).where('id NOT IN (?)',@members)
    else
      @friend_users = User.where('id IN (?)',@friends_of_user.map(&:first))
    end
  end

  # GET /groups/new
  def new
    @group = Group.new
    # @users = User.where("id !=?",current_user.id)
  end

  # GET /groups/1/edit
  def edit

  end

  # POST /groups
  # POST /groups.json
  def create
    if(current_user)
      if(group_params[:name])
        @group = Group.new(group_params)
        @group.user_id= current_user.id
        
        respond_to do |format|
          if @group.save
            @notify = Notification.new
            @notify.user_id= current_user.id
            @notify.content = 'has created group named  "'+@group.name+'"'
            @notify.save
            format.html { redirect_to '/groups/' , notice: 'Group was successfully created, add new members now.' }
            # format.json { render :show, status: :created, location: @group }
          else
            format.html { render :new }
            format.json { render json: @group.errors, status: :unprocessable_entity }
          end
        end
      else
        flash[:notice] = 'Group name is requierd.'
        redirect_to '/groups/new'

      end

    else
      redirect_to "/users/sign_in"
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        @notify = Notification.new
        @notify.user_id= current_user.id
        @notify.content = 'has updated group named  "'+@group.name+'"'
        @notify.save
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.group_members.destroy
    
    @notify = Notification.new
        @notify.user_id= current_user.id
        @notify.content = 'has deleted group named  "'+@group.name+'"'
        @notify.save
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :user_id)
    end
end
