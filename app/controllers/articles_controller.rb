class ArticlesController < ApplicationController
  allow_unauthenticated_access only: %i[ show ]
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :set_global_attributes, only: %i[ show ]
  layout "admin", except: [:show]

  def index
    @articles = Article.regular_articles(Category.available_categories).search(params[:query]).order(created_at: :desc).limit(20)
  end

  def show
    @article.visits += 1
    @article.save
  end

  def new
    @article = Article.new

    @article.language ||= "Español"

    if params[:multimedia_news] == 'true'
      @is_multimedia = true
    else
      @is_multimedia = false
    end

    if params[:people_news] == 'true'
      @is_people_news = true
    else
      @is_people_news = false
    end
  end

  def create
    multimedia_news = params[:multimedia_news]
    people_news = params[:people_news]
    @article = Article.new(article_params)

    if @article.save
      if multimedia_news
        # Find multimedia category
        @article.categories << Category.find(3)
      end

      if people_news
        @article.categories << Category.find(4)
      end

      if @article.is_multimedia?
        flash[:success] = "Nota multimedia creada correctamente"
        redirect_to "/multimedia"
      else
        if @article.is_people_news?
          flash[:success] = "Nota para Gente que Hace Noticia creada correctamente"
          redirect_to "/people_news"
        else
          flash[:success] = "Nota creada correctamente"
          redirect_to articles_path
        end
      end
    else
      flash[:error] = "Los campos no fueron llenados correctamente"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    if params[:multimedia_news] == 'true'
      @is_multimedia = true
    else
      @is_multimedia = false
    end

    if params[:people_news] == 'true'
      @is_people_news = true
    else
      @is_people_news = false
    end
  end

  def update
    if @article.update(article_params)
      if @article.is_multimedia?
        flash[:success] = "Nota multimedia actualizada correctamente"
        redirect_to "/multimedia"
      else
        if @article.is_people_news?
          redirect_to "/people_news"
        else
          if @article.is_last_moment_news?
            flash[:success] = "Nota de último momento actualizada"
            redirect_to edit_article_path(@article)
          else
            flash[:success] = "Nota actualizada correctamente"
            redirect_to articles_path  
          end
        end
      end
    else
      flash[:error] = "Los campos no fueron llenados correctamente"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    is_article_multimedia = @article.is_multimedia?
    is_article_people_news = @article.is_people_news?
    @article.destroy
    if is_article_multimedia
      redirect_to "/multimedia"
    else
      if is_article_people_news
        redirect_to "/people_news"
      else
        redirect_to articles_path    
      end
    end
  end

  def people_news
    @articles = Article.people_news
  end

  def last_moment
    article = Article.last_moment
    redirect_to edit_article_path(article)
  end

  def multimedia
    @articles = Article.multimedia
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def set_global_attributes
      @trending_articles = Article.trending.limit(3)
      @other_articles = Article.order(created_at: :desc).limit(4)

      # Used in sidebar
      @categories = Category.all

      @small_ad = Ad.small_ad
      @lateral_ad = Ad.lateral_ad
      @bottom_ad = Ad.bottom_ad
    end

    def article_params
      permitted = params.expect(article: [ :title, :author, :content, :language, :video_url, :main_image, category_ids: [] ])
    end
end
