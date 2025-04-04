class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :set_global_attributes, only: %i[ show ]
  layout "admin", except: [:show]

  def index
    @articles = Article.regular_articles(Category.available_categories).search(params[:query]).order(created_at: :desc)
  end

  def show
    @article.visits += 1
    @article.save
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
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
            flash[:success] = "Nota para Gente que Hace Noticia actualizada correctamente"
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
      @other_articles = Article.order(:created_at).limit(3)

      # Used in sidebar
      @categories = Category.all
    end

    def article_params
      params.expect(article: [ :title, :author, :content, :language, :video_url, :category_id, :main_image ])
    end
end
