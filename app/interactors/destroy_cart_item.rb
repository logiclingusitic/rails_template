class DestroyCartItem
  include Interactor

  def call
    decrement_quantity_or_destroy
    update_cart_totals

    context.success = true
  end

  private

  def decrement_quantity_or_destroy
    if context.cart_item.quantity > 1
      context.cart_item.quantity -= 1
      context.cart_item.save
    else
      context.cart_item.destroy
    end
  end

  def update_cart_totals
    product = context.cart_item.product
    context.user.cart.update(
      total_price: context.user.cart.total_price - product.price,
      total_products: context.user.cart.total_products - 1
    )
  end
end
