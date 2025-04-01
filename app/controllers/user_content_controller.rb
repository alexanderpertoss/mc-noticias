class UserContentController < ApplicationController
	def index
		# Get all the categories ordered based on the queue_position
		@categories = Category.order(queue_position: :desc)

		# Get all the categories that go after the multimedia sections
		@categories_for_main_page = Category.regular_categories

		# Get all the available categories, which excludes multimedia, gente que hace notica and ultimo momento
		available_categories = Category.available_categories

		# Get all articles for main slider
		@slider_articles = Article.carousel(available_categories)

		@remaining_articles = Article.summary(available_categories)
		
		# At most, get 4 articles to go next to the main slider ones
		@articles_for_top = Article.for_top(available_categories)

		# Get all articles for 'noticias destacadas'
		@highlighted_articles = Article.highlighted(available_categories)

		if @highlighted_articles.count > 0
			@highlighted_articles_category_name = @highlighted_articles.first.category.name
		else
			@highlighted_articles_category_name = "Noticias destacadas"
		end
		
		
		# Gente que hace noticia category
		@people_articles = Article.people_news

		@multimedia_articles = Article.multimedia.limit(8)
		@number_of_multimedia_articles = @multimedia_articles.count
		if @number_of_multimedia_articles > 2
			@number_of_multimedia_articles = 2
		end
		
		@trendind_articles = Article.trending.limit(3)

		#Testing this model
		@ad = Ad.first

		@latest_news_pill = Article.last_moment
	end

	def history
		@articles = Article.where.not(category_id: [8]).order(visits: :asc)
		# Gente que hace noticia category
		@people_articles = Category.find(4).articles.limit 5
		#Testing this model
		@ad = Ad.first
		@trendind_articles = Article.order(visits: :desc).limit(5)
		# For the footer
		@categories = Category.all
	end
end
