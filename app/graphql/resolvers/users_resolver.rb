module Resolvers
  class UsersResolver < BaseResolver
    type [Types::UserType], null: false

    def resolve
      users = User.all

      users.map do |user|
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
end
