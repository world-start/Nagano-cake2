class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.page(params[:page]).per(8)
    @number = Item.ids.count
  end

  
  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price)
  end
  
 

end
