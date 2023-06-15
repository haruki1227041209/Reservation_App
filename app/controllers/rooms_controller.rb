class RoomsController < ApplicationController
  before_action :require_login, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  def index
    @user = current_user
    @rooms = current_user.rooms
  end

  def index_toppage
    @user = current_user
    @rooms = Room.all
    @rooms = @rooms.search_by_address(params[:search_address]) if params[:search_address].present?
  end

  def new
    @user = current_user
    @room = Room.new
  end

  def create
    @user = current_user
    @room = Room.new(room_params)
    @room.user = @user
    if @room.save
      session[:user_id] = @user.id
      redirect_to user_room_path(user_id: @user.id, id: @room.id), notice: '施設を登録しました'
    else
      flash.now[:error] = '施設の登録に失敗しました'
      render :new
    end
  end

  def show
    @user = current_user
    @room = Room.find(params[:id])
    p @room.room_image
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def search
    @query = params[:search_query]
    @rooms = Room.where("room_name LIKE :query OR description LIKE :query", query: "%#{@query}%")
    @rooms = @rooms.where("address LIKE ?", "%#{params[:search_address]}%") if params[:search_address].present?
    @user = current_user
  end  

  private
  def room_params
    params.require(:room).permit(:room_image, :room_name, :description, :room_fee, :address)
  end

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end
end
