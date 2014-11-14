class OrdersController < ApplicationController
  before_action :find_room, except: [:index]

  def index
  	@orders = Order.all
  end
  def new
  	@order = Order.new
  end

  def create
  	@order = Order.new(order_params)
  	@order.user = current_user
  	@order.room = @room
  	if @order.save
  		Stripe.api_key = 'sk_test_5b4UqeUT48FGf5Sg3kqXIG0q'
		 Stripe::Charge.create(
		  :amount => @order.room.price_in_pence,
		  :currency => "usd",
		  :card => @order.stripe_token, # obtained with Stripe.js
		  :description => "Charge for #{@order.user.email}"
		)
		flash[:success] = "Order created"
  		redirect_to user_orders_path(current_user)
  	else
  		flash[:error] = "Sorry, no room at the inn"
  		flash[:more] = @order.errors.full_messages
  		render :new
  	end
 end

  private
  def order_params
  	params.require(:order).permit(:check_in,:check_out,:stripe_token,:user_id,:room_id)
  end
  def find_room
  	@room = Room.find(params[:room_id])
  end
end
