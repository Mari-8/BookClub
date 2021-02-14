# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes) - [User has_many :books] 
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User) - [Book belongs_to :users]
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients) - [has_many :books, through: :reviews]
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients) [user has_many :entered_discussions, through: :comments, source: :discussion]
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity) - [post has_many :users, through: :comments(content)]
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item) - - [User, Book, Bookshelf, Review. various validations on presence of title, password, ect. and some length requirements.]
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User. [most_recipes URL: /users/most_recipes) - [User.favorite_books(user), users/:id/favorite_books]
- [x] Include signup
- [x] Include login
- [x] Include logout
- [x] Include third party signup/login (how e.g. Devise/OmniAuth) [github, google, facebook]
- [x] Include nested resource show or index (URL e.g. users/2/recipes) [books/1/reviews]
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new) [books/1/reviews/new]
- [x] Include form display of validation errors (form URL e.g. /recipes/new) [flash messages on layout]

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers [As much as possible]
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate [_coment, _book]
