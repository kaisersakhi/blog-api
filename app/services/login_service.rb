# frozen_string_literal: true

class LoginService < Services
  def initialize(params)
    @email = params[:email]
    @password = params[:password]
    @author = Author.find_by(email: @email)
  end

  def authentic?
    @authentic ||= @author&.authenticate(@password) ? true : false
  end

  def response
    @response ||= if authentic?
                    {
                      author_id: @author.id,
                      token: token
                    }
                  else
                    {
                      errors: ["Invalid email or password"]
                    }
                  end
  end

  private
  def token
    auth_token = @author.auth_token
    auth_token = new_token(@author) if auth_token.nil?
    auth_token
  end

end
