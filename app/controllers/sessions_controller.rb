class SessionsController < ApplicationController
    
    def new 

    end 

    def omniauth 
        user = User.create_from_omniauth(auth)

        if user.save 
            session[:user_id] = user.id 
            redirect_to user_path(user)
        else 
            flash[:alert] = user.errors.full_messages.join(", ")
            redirect_to welcome_path 
        end 
    end 
    
    
    
    def create
        user = User.find_by(username: params[:username])
        
        if user && user.authenticate(params[:password]) 
            session[:user_id] = user.id
            redirect_to user_path(user), notice: 'Successfully logged in!'
        else 
            flash.now.alert = "Incorrect email or password, try again."
            render :'users/landing' 
        end 
      end

    def destroy
      session.delete(:user_id)
      redirect_to '/', notice: "Logged out!"
    end
     
      private
     
      def auth
        request.env['omniauth.auth']
      end
end
