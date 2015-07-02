class OrderItemsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    @order = current_order
    @order_item = @order.order_items.build(book: book)
    @order.save
    if @order_item.save
      flash[:success] = "Order Item created."
      redirect_to @order_item.cart
    else
      flash[:danger] = "Some error."
      redirect_to root_path
    end
  end

  # private

  # def order_item_params
  #   params.require(:order_item).permit(:quantity, :book_id)
  # end
end
