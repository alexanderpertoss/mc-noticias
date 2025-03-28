class Article < ApplicationRecord
  include ArticleScopes
  has_rich_text :content
  has_one_attached :main_image
  belongs_to :category
  
  after_initialize :set_defaults
  
  validates :title, presence: true, length: { minimum: 5 }
  validates :author, presence: true, length: { minimum: 5 }
  validates :language, presence: true
  validates :video_url, format: { with: /\Ahttps?:\/\/[\S]+\z/, message: "must be a valid URL" }, allow_blank: true
  validates :category_id, presence: true

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

  def is_multimedia?
    category.id == 3
  end

  def is_people_news?
    category.id == 4
  end

  def is_last_moment_news?
    category.id == 8
  end

  private
  def set_defaults
    self.visits ||= 0
  end
end
