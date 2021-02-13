class Book < ApplicationRecord
    belongs_to :user
    belongs_to :bookshelf
    has_many :reviews

    validates :bookshelf_id, presence: true 
    validates :title, presence: true 
    

    def create_from_google_books(user_input)
        results = GoogleBooks.search(user_input)
        book = results.first 
        book = Book.create(title: book.title, author_name: book.authors, image_url: book.image_link, description: book.description)
    end 

end
  