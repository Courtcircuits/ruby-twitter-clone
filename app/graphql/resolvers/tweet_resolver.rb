module Resolvers
  class TweetResolver < BaseResolver
    type Types::TweetType, null: false
    argument :id, ID

    def resolve(id:)
      Tweet.find(id)
    end
  end
end
