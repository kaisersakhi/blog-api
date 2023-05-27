# frozen_string_literal: true

class Services
  def new_token(author)
    timestamp_str = (Time.now.to_i * 1000).to_s
    token = Digest::SHA2.hexdigest(author.name + author.email + author.password_digest + timestamp_str)
    author.auth_token = token
    author.save!
    token
  end
end
