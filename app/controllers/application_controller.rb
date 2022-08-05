class ApplicationController < ActionController::API
  def database_error(error_object)
    render json: Api::V1::ErrorSerializer.error_json(error_object.errors.full_messages.to_sentence), status: 400
  end

  def find_teas
    @teas = params[:tea].map { |tea| Tea.find_by(title: tea) }
  end

  def find_price
    prices = @teas.map { |tea| tea.price }
    @price = prices.sum
  end

  def subscription_attributes
    {user_id: params[:user_id], frequency: params[:frequency], price: @price}
  end
end
