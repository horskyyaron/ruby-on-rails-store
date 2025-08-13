class ProductsController < ApplicationController
  # this is an action! ('index' action) an entry point so rails will know where to go after a route has been
  # requested. this action will render `app/views/products/index.html.erb`.
  def index
    # here we can query the db, and assing a variable for the result.
    # and access the variable in the index.html.erb file
    # like in the rails console!
    @products = Product.all
  end
end
