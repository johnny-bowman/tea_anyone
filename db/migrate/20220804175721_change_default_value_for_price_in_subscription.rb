class ChangeDefaultValueForPriceInSubscription < ActiveRecord::Migration[5.2]
  def change
    change_column_default :subscriptions, :price, 0.0
  end
end
