class AddPriceToTea < ActiveRecord::Migration[5.2]
  def change
    add_column :teas, :price, :float
  end
end
