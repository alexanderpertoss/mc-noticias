class UserContentController < ApplicationController
	def index
		# Get all the categories ordered based on the queue_position
		@categories = Category.order(queue_position: :desc)

		@categories_for_main_page = Category.regular_categories

		# Get all articles for main slider (Category #2 is the one for slider)
		@slider_articles = Article.carousel


		# Get all articles except the ones for the slider
		@articles = Article.where.not(category_id: [1, 2, 8])
		@remaining_articles = Article.summary
		
		# At most, get 4 articles to go next to the main slider ones
		@articles_for_top = Article.for_top
		

		# Get all articles for 'noticias destacadas'
		@highlithed_articles = Article.highlighted
		@number_of_highlighted_articles = @highlithed_articles.count
		if @number_of_highlighted_articles > 4
			@number_of_highlighted_articles = 4
		end

		
		# Gente que hace noticia category
		@people_articles = Article.people_news

		@multimedia_articles = Article.multimedia
		@number_of_multimedia_articles = @multimedia_articles.count
		if @number_of_multimedia_articles > 4
			@number_of_multimedia_articles = 4
		end
		
		@trendind_articles = Article.order(visits: :desc).limit(5)

		#Testing this model
		@ad = Ad.first

		@latest_news_pill = Category.find(8).articles.last

		
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
