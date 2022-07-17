require 'rails_helper'

RSpec.describe "cart_items/index", type: :view do
  before(:each) do
    assign(:cart_items, [
      CartItem.create!(
        user: nil,
        listing: nil,
        cart_num: "",
        delivery_fee: nil
      ),
      CartItem.create!(
        user: nil,
        listing: nil,
        cart_num: "",
        delivery_fee: nil
      )
    ])
  end

  it "renders a list of cart_items" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
