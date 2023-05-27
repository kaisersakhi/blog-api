class ArticlesController < ApplicationController
  before_action :authenticate_author, only: :create

  def index
    articles = Article.all
    render json: ArticlesRepresenter.new(articles).as_json
  end
  def show
    presenter = ArticleRepresenter.new(params[:id])
    render json: presenter.as_json, status: presenter.is_present? ? :ok : :bad_request
  end

  def create
    article_service = ArticleService.new(params, current_user)
    if article_service.valid?
      render json: article_service.response, status: :created
    else
      render json: article_service.response, status: :unprocessable_entity #422
    end
  end
end
