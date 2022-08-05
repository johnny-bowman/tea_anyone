class Api::V1::SubscriptionController < ApplicationController
  before_action :find_teas, only: [:create]
  before_action :find_price, only: [:create]
  before_action :subscription_attributes, only: [:create]

  def index
    user = User.find(params[:id])
    render json: Api::V1::SubscriptionSerializer.subscription_index(user.subscriptions), status: 200
  end

  def create
    sub = Subscription.new(subscription_attributes)
    if sub.save
      @teas.each do |tea|
        TeaSubscription.create!(tea_id: tea.id, subscription_id: sub.id)
      end
      render json: Api::V1::SubscriptionSerializer.create_subscription(sub, params[:tea]), status: 201
    else
      database_error(sub)
    end
  end

  def update
    sub = Subscription.find(params[:id])
    sub.update(status: 1)
    if sub.save
      render json: Api::V1::SubscriptionSerializer.cancel_subscription(sub), status: 200
    else
      database_error(sub)
    end
  end

  private

  def subscription_params
    params.permit(:user_id, :tea, :frequency)
  end
end
