class BookshelvesController < ApplicationController

    before_action :require_login

    def new 
        @bookshelf = Bookshelf.new 
        @books = current_user.books
    end 

    def create 
        bookshelf = Bookshelf.create(bookshelf_params)
        bookshelf.user_id = current_user.id

        if bookshelf.save 
            flash[:notice] = "Successfully created shelf" 
            redirect_to bookshelf_path(bookshelf)
        else 
            flash[:alert] = "#{bookshelf.errors.full_messages.to_s}"
            redirect_to new_bookshelf_path 
        end 
       
    end 

    def show 
        @bookshelf = Bookshelf.find_by_id(params[:id])

        if !users_shelf(@bookshelf) 
            flash[:alert] = "Cannot view another users bookshelf" 
            redirect_to user_path(current_user) 
        end 
    end 
    
    def index 
        @bookshelves = current_user.bookshelves 
    end 


    def edit 
        @bookshelf = Bookshelf.find(params[:id])

        if !users_shelf(@bookshelf) 
            flash[:alert] = "cannot edit another users shelf" 
            redirect_to user_path(current_user) 
        end 
    end 

    def update 
        @bookshelf = Bookshelf.find(params[:id])
        
        if users_shelf(@bookshelf) && @bookshelf.update(bookshelf_params)
            redirect_to bookshelf_path(@bookshelf) 
        else 
            flash[:alert] = "#{@bookshelf.errors.full_messages}"
            redirect_to user_path(current_user)
        end 
    end 

    def destroy 
        shelf = Bookshelf.find(params[:id])

        if users_shelf(shelf) 
            shelf.destroy 
            redirect_to bookshelves_path 
        else 
            flash[:alert] = "Cannot delete another users shelf"
        end 
    end 

    private 

    def bookshelf_params 
        params.require(:bookshelf).permit(:shelf_name)
    end 

    def require_login 
        return head(:forbidden) unless session.include? :user_id
    end 

    def users_shelf(bookshelf) 
        bookshelf.user_id == current_user.id 
    end 

end
