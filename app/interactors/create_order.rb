class CreateOrder
  include Interactor

  def call
    @order = context.user.orders.new(context.order_params)
    subtotal = context.user.cart.total_price
    tax = subtotal * 0.1
    total = subtotal + tax
    payment_method = "COD: Cash On Delivery"

    @order.update(subtotal: subtotal, tax: tax, total: total, payment_method: payment_method)

    if @order.save
      create_order_items
      update_cart_totals
      context.order = @order
      context.success = true
    else
      context.fail!(errors: @order.errors.full_messages)
    end
  end

  private

  def create_order_items
    context.user.cart_items.each do |cart_item|
      order_item = OrderItem.create(
        order: @order,
        product_name: cart_item.product.name,
        quantity: cart_item.quantity,
        price: cart_item.product.price
      )
      order_item.save
      cart_item.destroy
    end
  end

  def update_cart_totals
    context.user.cart.update(
      total_price: 0.0,
      total_products: 0
    )
  end
end
