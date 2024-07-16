module SessionsHelper
    def log_in (user)
        session[:user_id] = user.id
    end
    
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end
  
    def current_user
      
        if (user_id = session[:user_id])
        binding.pry
        @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
            binding.pry
            user = User.find_by(id: user_id)  
    
            if user && user.authenticated?(cookies[:remember_token])
                binding.pry
                log_in user
                @current_user = user
            end

        end
    end
    
    def forget(user)
        # In thông tin của user trước khi gọi phương thức forget
        puts "User ID: #{user.id}"
        puts "User Email: #{user.email}"
        puts "User Remember remember_digest: #{user.remember_digest}"
      
        user.forget
        cookies.delete :user_id
        cookies.delete :remember_digest
      
        # In thông tin của user sau khi gọi phương thức forget
        puts "User Remember Token after forget: #{user.remember_token}"
      end

      
    def logged_in?
        !current_user.nil?
    end

    def log_out 
        binding.pry
        forget(current_user)
        session.delete (:user_id)
        @current_user = nil
    end
    
end