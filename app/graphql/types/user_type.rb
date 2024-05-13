class Types::UserType < Types::BaseObject
  field :id, ID, null: false
  field :username, String, null: false
  field :display_name, String, null: false
  field :email, String, null: false
  field :tweets, [Types::TweetType], null: false
end
