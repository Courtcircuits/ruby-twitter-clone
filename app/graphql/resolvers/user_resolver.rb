module Resolvers
  class UserResolver < BaseResolver
    type Types::UserType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      user = User.find(id)

      {
        id: user.id,
        username: user.username,
        display_name: user.display_name,
        email: user.email,
        tweets: user.tweets
      }
    end
  end
end
