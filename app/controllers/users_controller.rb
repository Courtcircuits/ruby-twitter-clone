require 'jwt'

class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end 

  def create
    begin
      @user = User.new(user_params)
      @user.password = params[:password]
    rescue => e
      return render json: {error: e}, status: 400
    end
    if @user.save
      render json: {
        id: @user.id,
        username: @user.username,
        display_name: @user.display_name,
        email: @user.email,
      }
    else
      render json: {error: "Could not create user"}
    end
  end

  def login
    begin
      @user = User.find_by(email: login_params[:email])
    rescue =>e
      return render json: {error: e}
    end
    if @user && @user.authenticate(login_params[:password])
      token = JWT.encode({sub: @user.id, email: @user.email, scope: ["read", "write"]}, ENV['JWT_SECRET'], 'HS256') # user can read and write tweets
      return render json: {token: token}
    end  
    render json: {error: "Invalid email or password"}
  end

  def login_params
    parameters = params.permit(:email, :password)
    if parameters[:password].nil?
      raise "Password is required"
    elsif parameters[:email].nil?
      raise "Email is required"
    end
    return parameters
  end

  def user_params
    parameters = params.permit(:username, :email, :password, :display_name)
    if parameters[:password].nil?
      raise "Password is required"
    elsif parameters[:username].nil?
      raise "Name is required"
    elsif parameters[:email].nil?
      raise "Email is required"
    elsif parameters[:display_name].nil?
      raise "Display name is required"
    end
    return parameters
  end
end
