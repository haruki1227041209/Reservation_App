class ReservationsController < ApplicationController

  def index
    @user = current_user
    @reservations = current_user.reservations
    @reservations.each do |reservation|
      amount = reservation.room.room_fee * reservation.num_guests * reservation.stay_duration
    end
  end

  def new
    @user = current_user
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def create
    @user = current_user
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.user = @user
    @reservation.room = @room
    if @reservation.valid?
      session[:reservation_data] = @reservation.attributes
      redirect_to confirm_user_reservation_user_room_reservations_path(@user,@room,@reservation), notice: '予約を登録しました'
    else
      flash.now[:error] = '施設の登録に失敗しました'
      render :new
    end
  end

  def confirm
    @user = current_user
    @reservation_data = session[:reservation_data]
    @reservation = Reservation.new(@reservation_data)
  end

  def confirm_create
    @user = current_user
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.user = @user
    @reservation.room = @room
    if @reservation.save
      redirect_to reservations_index_path(@user,@room,@reservation), notice: '予約を登録しました'
    else
      flash.now[:error] = '施設の登録に失敗しました'
      render :new
    end
  end


  private
  def reservation_params
    params.require(:reservation).permit(:check_in_date, :check_out_date, :num_guests, :user_id, :room_id)
  end  

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end
end
