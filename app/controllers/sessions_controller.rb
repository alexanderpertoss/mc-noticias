class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }
  before_action :set_global_attributes

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end

  private
  def set_global_attributes
    # Get all the available categories, which excludes multimedia, gente que hace notica and ultimo momento
    @available_categories = Category.available_categories
    @categories = Category.order(queue_position: :desc)

    @trending_articles = Article.trending.limit(3)
    @other_articles = Article.regular_articles(@available_categories).limit(4)  

    # Gente que hace noticia category
    @people_articles = Article.people_news

    @small_ad = Ad.small_ad
    @lateral_ad = Ad.lateral_ad
    @bottom_ad = Ad.bottom_ad
    @podcast_ad = Ad.podcast_ad
  end
end