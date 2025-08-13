class ProductsController < ApplicationController
  # edit, update and show require an existing record!
  # thus, we can deduplicate into a before_action
  # before_action allows to extract share code between actions
  # and run it before the action
  before_action :set_product, only: %i[ show edit update destroy ]



  # this is an action! ('index' action) an entry point so rails will know where to go after a route has been
  # requested. this action will render `app/views/products/index.html.erb`.
  def index
    # here we can query the db, and assing a variable for the result.
    # and access the variable in the index.html.erb file
    # like in the rails console!
    @products = Product.all
  end

  def show
    # params[:id] will give us the id from the query paramaters
    # then we use it to query the db to find it
    # @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  # handles the data submitted by the form
  # but it needs to be filtered for security, thats where product_params comes in
  # it tells rails to inspect the params and ensure there is a key names :product
  # with an array of paramaters, the only one permitted is :name, it will 
  # ignore any other paramater
  #
  def create
    @product = Product.new(product_params)
    # this will try and save to db, it will run validation
    # if successfull, we want to redirect to the new product.
    # when redirect_to is given an Active Record object, rails generate the a path
    # for that record's *show* action
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @product = Product.find(params[:id])
  end

  def update
    # @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.expect(product: [ :name ])
    end
end
