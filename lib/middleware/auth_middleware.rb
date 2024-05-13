class AuthMiddleware
  def initialize(app)
    @app = app
  end


  def trigger_on_route(env) # Im sure there is a better way to do this
    request = Rack::Request.new(env)
    if request.path == '/graphql'
      return true
    elsif request.path == '/tweets' and request.request_method == 'POST'
      return true
    end
    return false
  end

  def call(env)
    # request = Rack::Request.new(env)
    if !trigger_on_route(env)
      return @app.call(env)
    end
    puts "request : #{env['HTTP_AUTHORIZATION']}"
      if env['HTTP_AUTHORIZATION']
        token = env['HTTP_AUTHORIZATION'].split(' ').last
      decoded_token = JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')
      env[:current_user] = User.find(decoded_token.first['sub'])
      env[:scopes] = decoded_token.first['scopes']
    else
      return [401, {}, ['Authorization header required']]
    end
    @app.call(env)
  end
end

