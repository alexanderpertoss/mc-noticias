module ArticleScopes
  extend ActiveSupport::Concern

  included do
  def self.carousel(available_categories)
    category_ids = available_categories.is_a?(Array) ? available_categories.map(&:id) : available_categories.pluck(:id)

    joins(:categories)
      .where(categories: { id: category_ids })
      .order("categories.queue_position DESC, articles.created_at DESC")
  end

  def self.for_top(available_categories)
    second_category_id = available_categories.offset(1).limit(1).pluck(:id).first

    joins(:categories)
      .where(categories: { id: second_category_id })
      .order(created_at: :desc)
  end

  def self.highlighted(available_categories)
    third_category_id = available_categories.offset(1).limit(1).pluck(:id).first

    joins(:categories)
      .where(categories: { id: third_category_id })
      .order(created_at: :desc)
      .limit(8)
  end

  def self.summary(available_categories)
    # Ignore the first category
    categories_for_summary = available_categories.offset(1)
    category_ids = categories_for_summary.is_a?(Array) ? categories_for_summary.map(&:id) : categories_for_summary.pluck(:id)

    joins(:categories)
      .where(categories: { id: category_ids })
      .order(created_at: :desc)
  end

  def self.multimedia
    joins(:categories)
      .where(categories: { id: 3 })
      .order(created_at: :desc)
  end

  def self.regular_articles(available_categories)
    category_ids = available_categories.is_a?(Array) ? available_categories.map(&:id) : available_categories.pluck(:id)

    joins(:categories)
      .where(categories: { id: category_ids })
      .distinct
      .order(created_at: :desc)
  end

  def self.people_news
    joins(:categories)
      .where(categories: { id: 4 })
      .order(created_at: :desc)
  end

  def self.last_moment
    joins(:categories)
      .where(categories: { id: 8 })
      .order(created_at: :desc)
      .first
  end

  def self.trending
      order(visits: :desc)
  end
  end
end
