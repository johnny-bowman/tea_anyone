class Subscription < ApplicationRecord
  belongs_to :user
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions

  validates_presence_of :user_id, :price, :status, :frequency
  validates :price, numericality: true
  validates :frequency, numericality: true

  enum status: { active: 0, cancelled: 1}
end
