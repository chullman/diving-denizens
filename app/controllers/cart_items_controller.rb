class CartItemsController < ApplicationController
  #before_action :set_cart_item, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ show_cart destroy ]

  # GET /cart_items or /cart_items.json
  # def index
  #   @cart_items = CartItem.all
  # end

  # GET /cart_items/1 or /cart_items/1.json
  def show_cart
    @cart_items = CartItem.where(user_id: current_user.id)

    # Because the user's cart may contain items from more than one seller
    # we need to calculate how many different sellers the buyer is buying from in the one cart order
    # so that we can calculate the correct delivery cost
    all_sellers_in_cart = []

    @cart_items.each do |cart_item|
      all_sellers_in_cart.push(cart_item.listing.user.id)
    end

    all_sellers_in_cart.uniq!

    @count_of_sellers = all_sellers_in_cart.length

    @total_delivery_cost = DeliveryFee.all.first.fee_price * @count_of_sellers

    render "show"
  end

  # GET /cart_items/new
  # def new
  #   @cart_item = CartItem.new
  # end

  # GET /cart_items/1/edit
  # def edit
  # end

  # POST /cart_items or /cart_items.json
  # def create
  #   @cart_item = CartItem.new(cart_item_params)

  #   respond_to do |format|
  #     if @cart_item.save
  #       format.html { redirect_to cart_item_url(@cart_item), notice: "Cart item was successfully created." }
  #       format.json { render :show, status: :created, location: @cart_item }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @cart_item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /cart_items/1 or /cart_items/1.json
  # def update
  #   respond_to do |format|
  #     if @cart_item.update(cart_item_params)
  #       format.html { redirect_to cart_item_url(@cart_item), notice: "Cart item was successfully updated." }
  #       format.json { render :show, status: :ok, location: @cart_item }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @cart_item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /cart_items/1 or /cart_items/1.json
  def destroy
    @cart_item.destroy

    respond_to do |format|
      format.html { redirect_to cart_items_url, notice: "Cart item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_cart_item
    #   @cart_item = CartItem.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def cart_item_params
      params.require(:cart_item).permit(:user_id, :listing_id, :cart_num, :delivery_fee_id)
    end
end
