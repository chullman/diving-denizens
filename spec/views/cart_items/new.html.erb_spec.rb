require 'rails_helper'

RSpec.describe "cart_items/new", type: :view do
  before(:each) do
    assign(:cart_item, CartItem.new(
      user: nil,
      listing: nil,
      cart_num: "",
      delivery_fee: nil
    ))
  end

  it "renders new cart_item form" do
    render

    assert_select "form[action=?][method=?]", cart_items_path, "post" do

      assert_select "input[name=?]", "cart_item[user_id]"

      assert_select "input[name=?]", "cart_item[listing_id]"

      assert_select "input[name=?]", "cart_item[cart_num]"

      assert_select "input[name=?]", "cart_item[delivery_fee_id]"
    end
  end
end
