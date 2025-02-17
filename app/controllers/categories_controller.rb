class CategoriesController < ApplicationController
	before_action :set_category, only: %i[ show edit update destroy ]
  layout "admin", except: %i[ show ]

  def index
    @categories = Category.all
  end

  def show
    #Testing this model
    @ad = Ad.first

    # For the footer
    @categories = Category.all

    @articles = @category.articles

    # Gente que hace noticia category
    @people_articles = Category.find(4).articles.limit 5
    @trendind_articles = Article.order(visits: :desc).limit(5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.expect(category: [ :name, :description ])
    end
end
