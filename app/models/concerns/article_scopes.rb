module ArticleScopes
  extend ActiveSupport::Concern

  included do

    def self.carousel(available_categories)
      categories_ids = available_categories.is_a?(Array) ? available_categories.map(&:id) : available_categories.pluck(:id)

      joins(:category)
        .where(categories: { id: categories_ids })  # Filter articles by these category IDs
        .order("categories.queue_position DESC, articles.created_at DESC")
        .limit(3)
    end

    def self.for_top(available_categories)
      second_category_id = available_categories.offset(1).limit(1).pluck(:id).first

      where(category_id: second_category_id)
        .order(created_at: :desc)
        .limit(4)
    end

    def self.highlighted(available_categories)
      third_category_id = available_categories.offset(2).limit(1).pluck(:id).first

      where(category_id: third_category_id)
        .order(created_at: :desc)
        .limit(8)
    end

    def self.summary(available_categories)
      # Ignore the first three categories because those go at the top
      available_categories = available_categories.offset(3)

      categories_ids = available_categories.is_a?(Array) ? available_categories.map(&:id) : available_categories.pluck(:id)

      where(category_id: categories_ids)
        .order(created_at: :desc)
        .limit(6)
    end

    def self.multimedia
      #get the articles with category_id=3 for multimedia
      where(category_id: 3)
        .order(created_at: :desc)
    end

    def self.regular_articles(available_categories)
      categories_ids = available_categories.is_a?(Array) ? available_categories.map(&:id) : available_categories.pluck(:id)

      where(category_id: categories_ids)
        .order(created_at: :desc)
    end

    def self.people_news
      #get the articles with category_id=4 for gente que hace noticia
      where(category_id: 4)
        .order(created_at: :desc)
    end

    def self.last_moment
      #get the articles with category_id=8 for ultimo momento
      where(category_id: 8)
        .order(created_at: :desc).first
    end

  end
end
