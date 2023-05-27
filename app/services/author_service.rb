# frozen_string_literal: true

class AuthorService < Services
  def initialize(params)
    @name = params[:name]
    @email = params[:email]
    @password = params[:password]
    @author = Author.new(name: @name, email: @email, password: @password)
    @author.save
  end

  def is_valid?
    @author.valid?
  end

  def response
    @response ||= if is_valid?
                    token = new_token(@author)
                    {
                      author: @author.as_json(except: %i[password_digest auth_token]),
                      token: token
                    }
                  else
                    {
                      errors: @author.errors.full_messages
                    }
                  end
  end
end

