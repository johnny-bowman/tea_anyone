class Api::V1::SubscriptionController < ApplicationController
  before_action :find_teas, only: [:create]
  before_action :find_price, only: [:create]
  before_action :subscription_attributes, only: [:create]

  def index
  end

  def create
    sub = Subscription.new(subscription_attributes)
    # binding.pry
    if sub.save
      @teas.each do |tea|
        TeaSubscription.create!(tea_id: tea.id, subscription_id: sub.id)
      end
      render json: Api::V1::SubscriptionSerializer.create_subscription(sub, params[:tea]), status: 201
    else
      database_error(sub)
    end
  end

  def destroy
  end

  private

  def subscription_params
    params.permit(:user_id, :tea, :frequency)
  end
end
