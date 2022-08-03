class User < ApplicationRecord
  has_many :subscriptions
  has_many :tea_subscriptions, through: :subscriptions
  has_many :teas, through: :tea_subscriptions

  validates_presence_of :first_name, :last_name, :email, :address
  validates_uniqueness_of :email, :address
end
