class Admin::HomesController < ApplicationController
 def top
  @orders = Order.page(params[:page]).reverse_order
 end
 
 
private
def order_params
 params.require(:order).permit(:name, :order_status)
end

end
