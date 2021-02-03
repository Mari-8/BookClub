class SessionsController < ApplicationController
    
    def new 

    end 

    def omniauth 
        user = User.create_from_omniauth(auth)

        if user.save 
            session[:user_id] = user.id 
            redirect_to user_path(user)
        else 
            flash[:message] = user.errors.full_messages.join(", ")
            redirect_to welcome_path 
        end 
    end 
    
    
    
    def create
        user = User.find_by(email: params[:login][:email])
        
        if user && user.authenticate(params[:login][:password]) 
            session[:user_id] = user.id
            redirect_to user_path, notice: 'Successfully logged in!'
        else 
            flash.now.alert = "Incorrect email or password, try again."
            render :new 
        end 
      end

    def destroy
      session.delete(:user_id)
      redirect_to landing_path, notice: "Logged out!"
    end
     
      private
     
      def auth
        request.env['omniauth.auth']
      end
end
