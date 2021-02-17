class JsonWebToken

  JWT_SECRET = ENV["JWT_SECRET"]
  
  def self.encode payload

    expiration = 2.weeks.from_now.to_i

    JWT.encode payload.merge(exp: expiration), JWT_SECRET

  end

  def self.decode token

    JWT.decode(token, JWT_SECRET).first
    
  end

end