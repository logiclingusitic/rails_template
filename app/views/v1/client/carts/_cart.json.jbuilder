json.extract! cart, :id, :total_price, :total_products, :user_id, :created_at, :updated_at
json.url cart_url(cart, format: :json)
