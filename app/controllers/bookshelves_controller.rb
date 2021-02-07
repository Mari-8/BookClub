class BookshelvesController < ApplicationController

    def new 
        @bookshelf = Bookshelf.new 
        @books = current_user.books
    end 

    def create 
        bookshelf = Bookshelf.create(shelf_name: params[:bookshelf][:shelf_name])
        bookshelf.user_id = current_user.id

        if bookshelf.save 
            flash[:notice] = "Successfully created shelf" 
            redirect_to bookshelf_path(bookshelf)
        else 
            flash[:alert] = bookshelf.errors.full_messages.to_sentence
            redirect_to new_bookshelf_path 
        end 
       
    end 

    def show 
        @bookshelf = Bookshelf.find_by_id(params[:id])
    end 
    
    def index 
        @bookshelves = Bookshelf.all
    end 


    def edit 

    end 

    def destroy 

    end 


end
