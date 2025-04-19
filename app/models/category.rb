class Category < ApplicationRecord
	has_many :articles
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

   		
   		categories = where.not(id: excluded_category_ids)
		  .joins(:articles)
		  .group('categories.id')
		  .having('COUNT(articles.id) > 0')
		  .order(queue_position: :desc)
		  .offset(3)
  	end

  	def is_multimedia?
  		# Multimedia category is 3
  		category.id == 3
  	end

  	private
  	def set_defaults
  	  self.queue_position ||= 0
  	end
end
