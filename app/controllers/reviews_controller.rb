class ReviewsController < ApplicationController

    def new 
        @review = Review.new 
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
            @reviews = Review.all 
        end 
    end     

    def show 
        @review = Review.find_by_id(params[:id])
    end 

    def edit 
        @review = Review.find(params[:id])
    end 

    def update 
        @review = Review.find(params[:id])
        @review.update(review_params) 

        redirect_to review_path(@review) 
    end 

    def destroy 
        Review.find(params[:id]).destroy
        redirect_to reviews_path
    end 

    private 

    def review_params
        params.require(:review).permit(:title, :content, :book_id, :user_id)
    end 
end
