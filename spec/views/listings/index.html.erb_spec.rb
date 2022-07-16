require 'rails_helper'

RSpec.describe "listings/index", type: :view do
  before(:each) do
    assign(:listings, [
      Listing.create!(
        user: nil,
        title: "Title",
        description: nil,
        images: nil,
        outright_price: "9.99",
        negotiable: false,
        quantity: 2,
        deliverable: false,
        listing_fee: nil
      ),
      Listing.create!(
        user: nil,
        title: "Title",
        description: nil,
        images: nil,
        outright_price: "9.99",
        negotiable: false,
        quantity: 2,
        deliverable: false,
        listing_fee: nil
      )
    ])
  end

  it "renders a list of listings" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
