class RoomsController < ApplicationController
  before_action :require_login, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  def index
    @user = current_user
    @rooms = Room.all
  end

  def new
    @user = current_user
    @room = Room.new
  end

  def create
    @user = User.find(params[:id])
    @room = Room.new(room_params)
    @room.user = @user
    puts "おはよう"
    if @room.save
      puts "Redirecting to: #{user_room_path(user_id: @user.id, id: @room.id)}"
      redirect_to user_room_path(user_id: @user.id, id: @room.id), notice: '施設を登録しました'
    else
      flash.now[:error] = '施設の登録に失敗しました'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @room = Room.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def room_params
    params.require(:room).permit(:room_image, :room_name, :description, :room_fee, :address)
  end
end
