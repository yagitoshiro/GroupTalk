class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new

    respond_to do |format|
      if @room.save
        format.html { redirect_to "/#{@room.token}", notice: 'カンファレンスルームを作成しました。このルームは２４時間有効です。' }
        format.json { render action: 'show', status: :created, location: @room }
      else
        format.html { render action: 'new' }
        format.json { render json: @room.errors, status: 'カンファレンスルームの作成に失敗しました' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:token)
    end
end
