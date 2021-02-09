class ReviewsController < ApplicationController

    before_action :require_login

    def new 
        if params[:book_id]
            @review = Book.find(params[:book_id]).reviews.build
        else 
            @review = Review.new 
        end 
    end 

    def create 
        review = Review.create(review_params)
        review.user_id = current_user.id 
        
        if review.save 
            flash[:notice] = "Review created successfully!"
            redirect_to review_path(review) 
        else 
            flash[:alert] = "There was a problem creating the review, #{review.errors.full_messages}"
            redirect_to new_review_path 
        end 
    end     

    def index 
        if params[:book_id]
            @reviews = Book.find(params[:book_id]).reviews 
        else 
            @reviews = current_user.reviews 
        end 
    end     

    def show 
        @review = Review.find_by_id(params[:id])
        if !users_review(@review) 
            flash[:alert] = "Cannot view another users reviews" 
            redirect_to user_path(current_user) 
        end 
    end 

    def edit 
        @review = Review.find(params[:id])

        if !users_review(@review) 
            flash[:alert] = "Cannot edit another users review" 
            redirect_to user_path(current_user) 
        end 
    end 

    def update 
        @review = Review.find(params[:id])

        if users_review(@review) && @review.update(review_params) 
            redirect_to review_path(@review) 
        else 
            flash[:alert] = "#{@review.errors.full_messages}"
        end 
    end 

    def destroy 
        review = Review.find(params[:id])

        if users_review(review) 
            review.destroy
            redirect_to reviews_path
        else 
            flash[:alert] = "Cannot delete another users review" 
            redirect_to reviews_path 
        end 
    end 

    private 

    def review_params
        params.require(:review).permit(:title, :content, :book_id)
    end 

    def require_login 
        return head(:forbidden) unless session.include? :user_id
    end 

end
