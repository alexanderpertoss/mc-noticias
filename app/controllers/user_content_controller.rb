class UserContentController < ApplicationController
	before_action :set_global_attributes

	def index		
		# Get all the categories that go after the multimedia sections
		@categories_for_main_page = Category.regular_categories		

		# Get all articles for main slider
		carousel_articles = Article.carousel(@available_categories)
		@slider_articles = carousel_articles.limit(3)
		# At most, get 4 articles to go next to the main slider ones
		@articles_for_top = carousel_articles.offset(3).limit(4)

		@remaining_articles = Article.summary(@available_categories)

		# Get all articles for 'noticias destacadas'
		@highlighted_articles = Article.highlighted(@available_categories)
		@highlighted_articles_count = @highlighted_articles.count
		if @highlighted_articles_count > 4
			@highlighted_articles_count = 4
		end

		if @highlighted_articles.count > 0
			@highlighted_articles_category_name = @highlighted_articles.first.category.name
		else
			@highlighted_articles_category_name = "Noticias destacadas"
		end

		@multimedia_articles = Article.multimedia.limit(8)
		@number_of_multimedia_articles = @multimedia_articles.count
		if @number_of_multimedia_articles > 2
			@number_of_multimedia_articles = 2
		end

		@latest_news_pill = Article.last_moment

		@podcasts = Podcast.order(created_at: :desc).limit(2)
	end

	def history
		@articles = Article.order(created_at: :desc).limit(10)
	end

	def contact
		
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
	end
end
