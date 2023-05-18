class CreateCartItem
  include Interactor

  def call
    cart_item = context.user.cart.cart_items.find_by(product: context.product)

    if cart_item
      increment_quantity(cart_item)
    else
      cart_item = create_new_cart_item
    end

    update_cart_totals

    if cart_item.persisted?
      context.success = true
    else
      context.success = false
    end
  end

  private

  def increment_quantity(cart_item)
    cart_item.quantity += 1
    cart_item.save
  end

  def create_new_cart_item
    CartItem.create(product: context.product, cart_id: context.user.cart.id, user: context.user, quantity: 1)
  end

  def update_cart_totals
    context.user.cart.update(
      total_price: context.user.cart.total_price + context.product.price,
      total_products: context.user.cart.total_products + 1
    )
  end
end
