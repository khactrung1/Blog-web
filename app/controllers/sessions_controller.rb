class SessionsController < ApplicationController
  def new

  end
  

  def create 
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
       binding.pry
       log_in user
       redirect_to user
    else
      flash[:danger] = 'Invalid email/password combination'
    end
  end

  def destroy

  end
end
