class Admin::OrdersController < ApplicationController
  
  def edit
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total = 0
      @order_items.each do |order_item|
        @total += order_item.subtotal #小計(税込)
      end
  end
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to edit_admin_order_path(@order)
  end
  
  private
  def order_params
    params.require(:order).permit(:customer_id, :name, :order_status)
  end
  
  def order_item_params
    params.require(:order_item).permit(:price, :amount, :making_status)
  end
end
