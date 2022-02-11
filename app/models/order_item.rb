class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
   
  def subtotal
    item.with_tax_price * amount
  end
  
end
