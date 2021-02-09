class ApplicationController < ActionController::Base
    helper_method :current_user
    helper_method :logged_in?

    def current_user
        if session[:user_id]
            @current_user ||= User.find(session[:user_id])
        else 
            nil 
        end 
    end

    def logged_in?    
        !current_user.nil?
    end

    def users_book(book)
        book.user_id == current_user.id
    end 

    def users_review(review)
        review.user_id == current_user.id
    end 
end
