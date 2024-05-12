class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all # no clue what the @ is for
    render json: @tweets
  end

  def show
    @tweet = Tweet.find(params[:id])
    render json: @tweet
  end

  def create
    puts "create"
    begin
      params = tweet_params
    rescue => e
      render json: {error: e.message}, status: :unprocessable_entity
    end
    @tweet = Tweet.new(title: params[:title], body: params[:body])
    if @tweet.save
      render json: @tweet, status: :created
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def tweet_params
    puts "tweet params"
    puts "params: #{params}"
    if params[:tweet][:title] == nil
      raise "Title is required"
    elsif params[:tweet][:body] == nil
      raise "Body is required"
    end
    return params[:tweet]
  end
end
