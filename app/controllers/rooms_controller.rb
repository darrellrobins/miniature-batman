class RoomsController < ApplicationController

  before_action :set_locale
  before_action :find_room, only: [:edit,:show,:update]
  before_action :require_user, except: [:index,:show]
 
  def index
  	if params[:search] and params[:search][:query]
  		@rooms = [{:name => 'My search result'}]
  		if @rooms.any?
  			flash.now[:success] = 'Rooms matching #{rooms.size}'
  		else
  			flash.now[:warning] = 'Sorry, no matching rooms here'
  		end
  	else
  		@rooms = Room.all
  	end
  end

  def show
  end

  def new
  	@room = Room.new
  end

  def create
  	@room = Room.new(room_params)
  	@room.user = current_user
  	if @room.save
  		flash[:success] = "Room created"
  		redirect_to rooms_path
  	else
  		flash[:error] = "Sorry, no room at the inn"
  		render :new
  	end
  end

  def edit
  	@room = Room.find(params[:id])
  	@user = User.find(current_user.id)
  	if ! @room
  		flash[:errors] = "No room"
  	end
  end

  def update
    if @room
      if @room.update(room_params)
        flash[:success] = @room.name + " updated"
      else
        flash[:error] = @room.name + " could not be updated"
        @room.errors.full_messages.each do | message |
          flash[:error] << "\n" + message
        end
        render :edit
       end
    else
      flash[:warning] = @room.id + " could not be found, not updated"
      render :edit
    end
    redirect_to rooms_path
  end

  def destroy
  	room = Room.find(params[:id])
  	if room
  		if room.delete
  			flash[:success] = room.name + " deleted"
  		else
  			flash[:error] = room.name + " could not be deleted"
  			room.errors.full_messages.each do | message |
  				flash[:error] << "\n" + message
  			end
  		end
  	else
  		flash[:warning] = room.name + " could not be found, not deleted"
  		render :edit
  	end
  	redirect_to rooms_path
  end

  private
  def room_params
  	params.require(:room).permit( 
  		:price_in_pence, 
  		:name, 
  		:description, 
  		:availability, 
  		:latitude, 
  		:longitude, 
  		:phone_no, 
  		:no_of_rooms, 
  		:max_guests, 
  		:pets, 
  		:address)
  end

  def find_room
  	@room = Room.find(params[:id])
  end

  def set_locale
    I18n.locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-zA-Z-]+[^,]/).first || I18n.default_locale
  end
end
