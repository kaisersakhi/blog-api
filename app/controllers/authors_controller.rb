class AuthorsController < ApplicationController

  before_action :authenticate_author, only: %i[logout]

  def show
    author = Author.find_by_id(params[:id])
    render json: { author: author.as_json(except: %i[password_digest auth_token created_at updated_at]) }
  end

  def create
    author_service = AuthorService.new(params)
    if author_service.is_valid?
      render json: author_service.response, status: :created
    else
      render json: author_service.response, status: :bad_request
    end
  end

  def login

    login_service = LoginService.new(params)
    if login_service.authentic?
      render json: login_service.response, status: :ok
    else
      render json: login_service.response, status: :unauthorized
    end
  end

  def logout
    current_user&.update!(auth_token: nil)
    render json: { status: "success" }, status: :ok
  end
end
