class Category < ApplicationRecord
	#has_many :articles
	has_many :article_categories, dependent: :destroy
  	has_many :articles, through: :article_categories
	validates :name, presence: true
	after_initialize :set_defaults

	def self.available_categories
    	# excluding the "ultimo momento" category with id=8 and multimedia with id=3 and "gente que hace noticia" with id=4
    	excluded_category_ids = [8, 3, 4]  

   		where.not(id: excluded_category_ids).order(queue_position: :desc)
  	end

	def self.regular_categories
    	# excluding the "ultimo momento" category with id=8 and multimedia with id=3 and "gente que hace noticia" with id=4
    	excluded_category_ids = [8, 3, 4]  

   		where.not(id: excluded_category_ids)
   		    .joins(:articles)
   		    .group('categories.id')
   		    .having('COUNT(articles.id) > 0')
   		    .order(queue_position: :desc)
   		    .offset(2)
  	end

  	def self.update_categories_queue_positions
  		excluded_category_ids = [8, 3, 4]  # Categories to exclude
  		ordered_categories = Category.where.not(id: excluded_category_ids).order(queue_position: :desc)
  		top_queue_position = ordered_categories.count

  		ordered_categories.each do |category|
  		  category.update!(queue_position: top_queue_position)
  		  top_queue_position -= 1
  		end
  	end

  	def is_multimedia?
  		# Multimedia category is 3
  		category.id == 3
  	end

  	private
  	def set_defaults
  	  self.queue_position ||= 1
  	end
end
