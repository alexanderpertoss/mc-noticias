class Article < ApplicationRecord
  include ArticleScopes

  
  has_rich_text :content
  has_one_attached :main_image
  belongs_to :category
  
  after_initialize :set_defaults
  
  validates :title, presence: true
  validates :author, presence: true
  validates :language, presence: true

  LANGUAGES = ["Español", "Quechua", "Inglés"].freeze

  scope :search, ->(query) {
      return if query.blank?

      joins(:category).where(
        "articles.title LIKE :q OR 
         articles.author LIKE :q OR 
         categories.name LIKE :q OR 
         strftime('%Y-%m-%d', articles.created_at) = :q",
        q: "%#{query}%"
      )
    }

  private
  def set_defaults
    self.visits ||= 0
  end
end
