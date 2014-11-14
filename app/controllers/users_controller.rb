class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create 
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "User created"
  		redirect_to rooms_path
  	else
  		flash[:error] = "Sorry, no room at the inn"
  		flash[:error] = @user.name + " could not be created"
  		@user.errors.full_messages.each do | message |
  			flash[:error] << "\n" + message
  		end
  		render :new
  	end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user
      if @user.update(user_params)
        flash[:success] = @user.name + " updated"
      else
        flash[:error] = @user.name + " could not be updated"
        @user.errors.full_messages.each do | message |
          flash[:error] << "\n" + message
        end
        render :edit
       end
    else
      flash[:warning] = @user.name + " could not be found, not updated"
      render :edit
    end
    redirect_to rooms_path

  end

  def show
  	@user = User.find(params[:id])
  end


  def destroy
  	user = User.find(params[:id])
  	if user
  		if user.delete
  			flash[:success] = user.name + " deleted"
  		else
  			flash[:error] = user.name + " could not be deleted"
  			user.errors.full_messages.each do | message |
  				flash[:error] << "\n" + message
  			end
  		end
  	else
  		flash[:warning] = user.name + " could not be found, not deleted"
  		render :edit
  	end
  	redirect_to rooms_path
  end

  def user_params
  	params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
