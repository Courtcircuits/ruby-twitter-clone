class CreateTweets < ActiveRecord::Migration[7.1]
  def change
    create_table :tweets do |t|
      t.text :body
      t.references :user, null: false, foreign_key: { to_table: :users}, index: {:name => "index_tweets_on_user_id"}

      t.timestamps
    end
  end
end
