module Resolvers
  class TweetsResolver < BaseResolver
    type [Types::TweetType], null: false

    def resolve
      Tweet.all
    end
  end
end
