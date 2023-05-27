# frozen_string_literal: true

class ArticlesRepresenter
  def initialize(articles)
    @articles = articles
  end

  def as_json
    articles.map do |article|
      {
        id: article.id,
        title: article.title,
        body: article.body,
        author: article.author.name,
        created_at: article.created_at
      }
    end
  end

  private
  attr_reader :articles
end
