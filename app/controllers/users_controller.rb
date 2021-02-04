class UsersController < ApplicationController


    def new 
        @user = User.new 
    end 
    
    def show 
        @user = User.find_by_id(params[:id])
    end 
    
    def create 
        @user = User.new(user_params)

        if @user.save
            flash[:notice] = "Account created successfully!"
            session[:user_id] = @user.id
            redirect_to user_path(@user)
          else
            flash.now.alert = "There was a problem creating the account. Please make sure you are using a valid email and password and try again."
            render :new
          end
    end 

    def landing  

    end 


    private 

    def user_params 
        params.require(:user).permit(:username, :password, :password_confirmation, :email, :bio)
    end 

end 