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
    begin
      validated_params = tweet_params
    rescue => e
      logger.error "Error: #{e.message}"
      return render json: {error: e.message}, status: :unprocessable_entity
    end
    @tweet = Tweet.new(body: validated_params[:body])
    if @tweet.save
      logger.info "Tweet created"
      render json: @tweet, status: :created
    else
      logger.error "Tweet not created"
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def tweet_params
    if params[:tweet][:body].nil?
      raise "Body is required"
    end
    return params[:tweet]
  end
end
