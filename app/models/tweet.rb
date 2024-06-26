class Tweet < ApplicationRecord
  belongs_to :user
  validates :body, length: { maximum: 140 }, presence: true
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }
end
