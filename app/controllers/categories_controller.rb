class CategoriesController < ApplicationController
  allow_unauthenticated_access only: %i[ show ]
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :set_global_attributes, only: %i[ show ]
  layout "admin", except: %i[ show ]

  def index
    # excluding the "ultimo momento" category with id=8 and multimedia with id=3 and "gente que hace noticia" with id=4
    excluded_category_ids = [ 8, 3, 4 ]  # Categories to exclude
    @categories = Category.where.not(id: excluded_category_ids).order(queue_position: :desc)
  end

  def show
    @articles = @category.articles.limit(16).order(created_at: :desc)

    # Gente que hace noticia category
    @people_articles = Article.people_news.limit(5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      Category.update_categories_queue_positions
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
    Category.update_categories_queue_positions
    redirect_to categories_path
  end

  def move_up
    @category = Category.find(params[:id])
    above_category = Category.where("queue_position > ?", @category.queue_position)
                               .order(queue_position: :asc)
                               .first

    if above_category
      above_category_queue_position = above_category.queue_position

      above_category.update!(queue_position: @category.queue_position)
      @category.update!(queue_position: above_category_queue_position)
    end

    Category.update_categories_queue_positions

    # excluding the "ultimo momento" category with id=8 and multimedia with id=3 and "gente que hace noticia" with id=4
    excluded_category_ids = [ 8, 3, 4 ]  # Categories to exclude
    @categories = Category.where.not(id: excluded_category_ids).order(queue_position: :desc)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to categories_path, notice: "Queue position updated!" }
    end
  end

  def move_down
    @category = Category.find(params[:id])
    below_category = Category.where("queue_position < ?", @category.queue_position)
                               .order(queue_position: :desc)
                               .first

    if below_category
      below_category_queue_position = below_category.queue_position

      below_category.update!(queue_position: @category.queue_position)
      @category.update!(queue_position: below_category_queue_position)

    end


    Category.update_categories_queue_positions

    # excluding the "ultimo momento" category with id=8 and multimedia with id=3 and "gente que hace noticia" with id=4
    excluded_category_ids = [ 8, 3, 4 ]  # Categories to exclude
    @categories = Category.where.not(id: excluded_category_ids).order(queue_position: :desc)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to categories_path, notice: "Queue position updated!" }
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def set_global_attributes
      @trending_articles = Article.trending.limit(3)
      @other_articles = Article.order(created_at: :desc).limit(4)

      # Used in sidebar
      @categories = Category.all

      @small_ad = Ad.small_ad
      @lateral_ad = Ad.lateral_ad
      @bottom_ad = Ad.bottom_ad
      @podcast_ad = Ad.podcast_ad
    end

    def category_params
      params.expect(category: [ :name, :description ])
    end
end
