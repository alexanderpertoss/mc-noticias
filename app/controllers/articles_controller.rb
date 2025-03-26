class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  layout "admin", except: [:show]

  def index
    @articles = Article.regular_articles
  end

  def show
    @article.visits += 1
    @article.save

    @other_articles = Article.limit 3

    # Used in sidebar
    @categories = Category.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  def people_news
    @articles = Article.people_news
  end

  def last_moment
    article = Article.last_moment
    redirect_to edit_article_path(article)
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.expect(article: [ :title, :author, :content, :language, :video_url, :category_id, :main_image ])
    end
end
