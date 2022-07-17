require 'rails_helper'

RSpec.describe "cart_items/edit", type: :view do
  before(:each) do
    @cart_item = assign(:cart_item, CartItem.create!(
      user: nil,
      listing: nil,
      cart_num: "",
      delivery_fee: nil
    ))
  end

  it "renders the edit cart_item form" do
    render

    assert_select "form[action=?][method=?]", cart_item_path(@cart_item), "post" do

      assert_select "input[name=?]", "cart_item[user_id]"

      assert_select "input[name=?]", "cart_item[listing_id]"

      assert_select "input[name=?]", "cart_item[cart_num]"

      assert_select "input[name=?]", "cart_item[delivery_fee_id]"
    end
  end
end
