json.extract! order, :id, :customer_name, :shipping_address, :phone_number, :payment_method, :user_id, :created_at, :updated_at
json.url order_url(order, format: :json)
