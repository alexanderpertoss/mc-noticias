class Article < ApplicationRecord
  has_rich_text :content
  has_one_attached :main_image
  belongs_to :category
  
  after_initialize :set_defaults
  
  validates :title, presence: true
  validates :author, presence: true
  validates :language, presence: true

  LANGUAGES = ["Español", "Quechua", "Inglés"].freeze

  scope :carousel, -> {
    joins(:category).order("categories.queue_position DESC, categories.id ASC, articles.created_at DESC").limit(5)
  }

  scope :for_top, -> {

    # excluding the "ultimo momento" category with id=8 and multimedia with id=3 and "gente que hace noticia" with id=4
    excluded_category_ids = [8, 3, 4]  # Categories to exclude

    second_category_id = Category.where.not(id: excluded_category_ids)  # Exclude before selecting
                                 .order(queue_position: :desc, id: :asc)
                                 .offset(1)
                                 .limit(1)
                                 .pluck(:id)
                                 .first


   # second_category_id = Category.order(queue_position: :desc, id: :asc).offset(1).limit(1).pluck(:id).first

    where(category_id: second_category_id)
      .order(created_at: :desc)
      .limit(4)
  }

  scope :highlighted, -> {
    third_category_id = Category.order(queue_position: :desc, id: :asc).offset(2).limit(1).pluck(:id).first

    where(category_id: third_category_id)
      .order(created_at: :desc)
  }

  scope :summary, -> {
    excluded_category_ids = Category.order(queue_position: :desc, id: :asc)
      .limit(3)
      .pluck(:id)

    # excluding the "ultimo momento" category with id=8 and multimedia with id=3 and "gente que hace noticia" with id=4
    excluded_category_ids.push 8, 3, 4

    where.not(category_id: excluded_category_ids)
      .order(created_at: :desc)
      .limit(6)
  }

  scope :multimedia, -> {
    #get the articles with category_id=3 for multimedia
    where(category_id: 3)
  }

  scope :regular_articles, -> {
    # excluding the "ultimo momento" category with id=8 and multimedia with id=3 and "gente que hace noticia" with id=4
    excluded_category_ids = [8, 3, 4]  

    where.not(category_id: excluded_category_ids).order(created_at: :desc)
  }

  private
  def set_defaults
    self.visits ||= 0
  end
end
