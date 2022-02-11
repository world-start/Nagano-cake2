class Public::OrdersController < ApplicationController
  
  def new
   @order = Order.new
   if current_customer.cart_items.count == 0
     redirect_to cart_items_path
   end
  # @order.addresses.build
  end
  
  
  def confirm
      @order = Order.new(order_params)
      @cart_items = current_customer.cart_items 
    
    if params[:select_address] == "0"
      #自身の住所をcreateアクションに送ってあげる
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
     
    elsif params[:select_address] == "1"
      #登録先住所から選ぶ→Addressモデルからどの住所にするか選ぶ
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:select_address] == "2"
      #@order = Order.new(order_params)
    end
    
     
      @cart_item = 0
      @cart_items.each do |cart_item|
        @cart_item += cart_item.subtotal #小計(税込)
      end
      
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save!
    
    # order item
    cart_items = current_customer.cart_items
    
    cart_items.each do |ci|
      order_item = OrderItem.new
      order_item.item_id = ci.item_id
      order_item.order_id = @order.id
      order_item.amount = ci.amount
      order_item.price = ci.item.price*ci.amount
      order_item.save
    end
    
    current_customer.cart_items = CartItem.all
    current_customer.cart_items.destroy_all

    redirect_to orders_thanks_path 
  end
  
  def thanks
  end
  
  
  def index
    @orders = current_customer.orders
  end
  
  def show
    @order = Order.find(params[:id])
    
  end
  
  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)
  end
end
