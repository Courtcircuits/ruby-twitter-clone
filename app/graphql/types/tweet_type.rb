class Types::TweetType < Types::BaseObject
  field :id, ID, null: false
  field :body, String, null: false
  field :user, Types::UserType, null: false
end
