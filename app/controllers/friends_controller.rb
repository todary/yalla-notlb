class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]

  # GET /friends
  # GET /friends.json
  def index
    #@friends = Friend.all
    @friends=Friend.where(user_id: current_user.id)
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new
    @friend.user_id = params[:user_id]
    @friend.friend_id = params[:friend][:friend_id]
    #friend=Friend.where(friend_id: @friend.friend_id)
    #friend=Friend.where("friend_id = #{params[:friend][:friend_id]}")
    #friend = Friend.find(:all, :conditions => { :friend_id => params[:friend][:friend_id] }, :limit => 1)
    friend = Friend.find_by_friend_id params[:friend][:friend_id]
    friend1 = Friend.find_by_user_id params[:user_id]
    #friend=Friend.where(user_id: params[:user_id], friend_id: params[:friend][:friend_id])


  unless friend && friend1

    respond_to do |format|
      if @friend.save
        #format.html { redirect_to @friend, notice: 'Friend was successfully created.' }
        format.html { redirect_to :action => 'index', notice: 'Friend was successfully created.' }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  
  else
    respond_to do |format|
      format.html { redirect_to :action => 'index', notice: 'Friend was added before.' }
      format.json { render :show, status: :unprocessable_entity, location: @friend }

    end  
  end
end

  # PATCH/PUT /friends/1
  # PATCH/PUT /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to @friend, notice: 'Friend was successfully updated.' }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url, notice: 'Friend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friend_params
      params.require(:friend).permit(:friend_id, :user_id)
    end
end
