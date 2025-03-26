class Category < ApplicationRecord
	has_many :articles

	validates :name, presence: true

	scope :regular_categories, -> {
    	# excluding the "ultimo momento" category with id=8 and multimedia with id=3 and "gente que hace noticia" with id=4
    	excluded_category_ids = [8, 3, 4]  

   		where.not(id: excluded_category_ids).order(queue_position: :desc).offset(3)
  	}
end
