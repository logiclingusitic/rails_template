class V1::Client::CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[ show edit update  ]

  # GET /cart_items or /cart_items.json
  def index
    @cart_items = CartItem.all
  end

  # GET /cart_items/1 or /cart_items/1.json
  def show
  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new
  end

  # GET /cart_items/1/edit
  def edit
  end

  # POST /cart_items or /cart_items.json

  def create
    product = Product.find(params[:product_id])
    result = CreateCartItem.call(user: current_user, product: product)

    if result.success?
      redirect_to v1_client_user_cart_path, notice: "Product added to cart successfully."
    else
      redirect_to root_path, alert: "Failed to add product to cart."
    end
  end

  # PATCH/PUT /cart_items/1 or /cart_items/1.json
  def update
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to cart_item_url(@cart_item), notice: "Cart item was successfully updated." }
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1 or /cart_items/1.json
  def destroy
    cart_item = current_user.cart.cart_items.find(params[:id])
    DestroyCartItem.call(cart_item: cart_item, user: current_user)

    redirect_to v1_client_user_cart_path, notice: "Cart item was successfully removed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_item_params
      params.require(:cart_item).permit(:product_id, :user_id, :quantity, :cart_id)
    end
end
