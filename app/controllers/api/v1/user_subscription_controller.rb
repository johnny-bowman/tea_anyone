class Api::V1::UserSubscriptionController < ApplicationController
  def index
    user = User.find(params[:id])
    render json: Api::V1::SubscriptionSerializer.subscription_index(user.subscriptions), status: 200
  end
end
