class Admin::ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
  if @item.save
    redirect_to admin_item_path(@item)#@item.idと同じ
  else
    render new_admin_item_path
  end
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def index
    @items = Item.page(params[:page]).reverse_order
  end
  
  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
  if @item.save
    redirect_to admin_item_path(@item)
  else
    render edit_admin_item_path(@item)
  end
  end

  private
  def item_params
    params.require(:item).permit(:name, :image, :introduction, :genre_id, :price, :is_active)  
  end
end
