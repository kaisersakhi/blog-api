# frozen_string_literal: true

class ArticleRepresenter
  def initialize(id)
    @article = Article.find_by_id(id)
  end

  def is_present?
    @article ? true : false
  end

  def as_json
    @response ||= if is_present?
                    {
                      id: article.id,
                      title: article.title,
                      body: article.body,
                      author: article.author.name,
                      date: article.created_at
                    }
                  else
                    {
                      error: ["No article present with the specified ID"]
                    }
                  end
  end

  private

  attr_reader :article
end
