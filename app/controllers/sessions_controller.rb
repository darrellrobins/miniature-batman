class SessionsController < ApplicationController
	def new
	end
	def create
		login = session_params
		user = User.find_by(:name => login[:name])
		if user.present? and user.authenticate(login[:password])
			flash[:success] = "found"
			reset_session
			session[:user_id] = user.id
			redirect_to rooms_path
		else
			flash[:error] = "No matching details for " + login[:name]
			render :new
		end
	end
	def destroy
		reset_session
		redirect_to rooms_path
	end

	private
	def session_params
		params.require(:session).permit(:name,:password)
	end
end
