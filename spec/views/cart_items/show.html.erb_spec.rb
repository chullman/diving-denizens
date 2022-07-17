require 'rails_helper'

RSpec.describe "cart_items/show", type: :view do
  before(:each) do
    @cart_item = assign(:cart_item, CartItem.create!(
      user: nil,
      listing: nil,
      cart_num: "",
      delivery_fee: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
