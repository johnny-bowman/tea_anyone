class ChangeDefaultValueForStatusInSubscription < ActiveRecord::Migration[5.2]
  def change
    change_column_default :subscriptions, :status, 0
  end
end
