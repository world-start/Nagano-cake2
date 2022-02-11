class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1}
  enum order_status: { wait: 0, confirmed: 1, making: 2, preparation: 3, sent: 4}
  has_many :order_items, dependent: :destroy
  belongs_to :customer
  

end
