class ReviewsController < ApplicationController

    def new 
        @review = Review.new 
    end 

    def create 

    end 

    def index 

    end 

    def show 
        @review = Review.find_by_id(params[:id])
    end 

    def edit 

    end 

    def destroy 

    end 
end
