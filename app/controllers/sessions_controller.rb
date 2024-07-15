class SessionsController < ApplicationController
  def new

  end
  

  def create 
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
       log_in user
       remember user
       redirect_to user
    else
      flash[:danger] = 'Invalid email/password combination'
    end
  end

  def destroy
    binding.pry
    log_out
    redirect_to root_path
  end
end
