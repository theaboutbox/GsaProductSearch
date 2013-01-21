class AddPriceToProducts < ActiveRecord::Migration
  def change
    add_money :products, :price
  end
end
