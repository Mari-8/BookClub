class BooksController < ApplicationController
    

    def new 
        @book = Book.new(bookshelf_id: params[:bookshelf_id])
    end 

    def index 
        @books = current_user.books
    end 

    def create 
        
        if params[:commit] == "Search" 
            book = Book.new.create_from_google_books(params[:book][:title])
            book.user_id = current_user.id
            book.bookshelf_id = params[:book][:bookshelf_id]
        else 
            book = Book.create(book_params)
            book.user_id = current_user.id 
            book.bookshelf_id = params[:book][:bookshelf_id]
        end 

      
        if book.save
            flash[:notice] = "You successfully added a book to your collection!"
            redirect_to book_path(book) 
        else 
            flash[:alert] = "Could not find that title, please try again or create your book manually!"
            redirect_to new_book_path 
        end   
    end 

    def show 
        @book = Book.find_by_id(params[:id])
    end 

    def index 
        @books = current_user.books
    end 

    def add_to_shelf 
        shelf_id = params[:bookshelf_id] 
        book = Book.find_by_id(params[:book][:book_id])
        book.bookshelf_id = shelf_id 

        if book.save 
            flash[:notice] = "Successfully added to shelf!" 
            redirect_to bookshelf_path(shelf_id)
        else 
            flash[:alert] = "There was an issue adding this title" 
            redirect_to bookshelf_path(shelf_id)
        end 
    end 


    private 

    def book_params
        params.require(:book).permit(:title, :description, :author_name, :bookshelf_id, :user_id)
    end
end
