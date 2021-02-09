class UsersController < ApplicationController

    before_action :require_login
    skip_before_action :require_login, only: [:new, :create]

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
            flash.now.alert = "There was a problem creating the account. Please make sure you are using a valid email and password and try again. #{@user.errors.full_messages.to_s}"
            render :new
          end
    end 

    def edit 
        @user = User.find(params[:id])
    end 

    def update 
        @user = User.find(params[:id])
        @user.update(user_params)

        redirect_to user_path(@user)
    end 

    def destroy 
        @user = User.find(params[:id]).destroy
        session.delete(:user_id) 

        redirect_to root_path 
    end 

    def favorite_books 
        @books = Book.favorite_books(current_user)
        
    end 


    private 

    def user_params 
        params.require(:user).permit(:username, :password, :password_confirmation, :email, :bio)
    end 

    def require_login 
        return head(:forbidden) unless session.include? :user_id
    end 

end 