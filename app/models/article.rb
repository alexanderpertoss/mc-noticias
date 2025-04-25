class Article < ApplicationRecord
  include ArticleScopes
  has_rich_text :content
  has_one_attached :main_image
  #belongs_to :category
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  
  after_initialize :set_defaults
  
  validates :title, presence: true, length: { minimum: 5 }
  validates :author, presence: true, length: { minimum: 5 }
  validates :language, presence: true
  validates :video_url, format: { with: /\Ahttps?:\/\/[\S]+\z/, message: "must be a valid URL" }, allow_blank: true
  #validates :category_id, presence: true

  LANGUAGES = ["Español", "Quechua", "Inglés"].freeze

  scope :search, ->(query) {
    return all if query.blank?

    joins(:categories).where(
      "articles.title LIKE :q OR 
       articles.author LIKE :q OR 
       categories.name LIKE :q OR 
       strftime('%Y-%m-%d', articles.created_at) = :q",
      q: "%#{query}%"
    ).distinct
  }

  def is_multimedia?
    category_ids.include?(3)
  end

  def is_people_news?
    category_ids.include?(4)
  end

  def is_last_moment_news?
    category_ids.include?(8)
  end

  private
  def set_defaults
    self.visits ||= 0
  end
end
