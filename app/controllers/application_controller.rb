class ApplicationController < ActionController::API

  before_action :authenticate_author, only: :current_user

  def authenticate_author
    author = Author.find_by(auth_token: request_token)
    if author.nil?
      render json: {errors: ["Invalid credentials."]}, status: :unauthorized
    end
  end

  def current_user
    Author.find_by(auth_token: request_token)
  end

  private

  def request_token
    params.required(:token)
  rescue
    ""
  end
end
