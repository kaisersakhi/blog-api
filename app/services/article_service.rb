# frozen_string_literal: true

class ArticleService < Services
  def initialize(params, author)
    @author = author
    @article = Article.new(
      title: params[:title],
      body: params[:body],
      author_id: author.id
    )
    @article.save
  end

  def valid?
    @article.valid?
  end

  def response
    @response ||= if valid?
                    {
                      id: article.id,
                      title: article.title,
                      body: article.body,
                      date: article.created_at,
                      author: author.name
                    }
                  else
                    {
                      errors: article.errors.full_messages
                    }
                  end
  end

  private

  attr_reader :author, :article
end
