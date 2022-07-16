require 'rails_helper'

RSpec.describe "listings/edit", type: :view do
  before(:each) do
    @listing = assign(:listing, Listing.create!(
      user: nil,
      title: "MyString",
      description: nil,
      images: nil,
      outright_price: "9.99",
      negotiable: false,
      quantity: 1,
      deliverable: false,
      listing_fee: nil
    ))
  end

  it "renders the edit listing form" do
    render

    assert_select "form[action=?][method=?]", listing_path(@listing), "post" do

      assert_select "input[name=?]", "listing[user_id]"

      assert_select "input[name=?]", "listing[title]"

      assert_select "input[name=?]", "listing[description]"

      assert_select "input[name=?]", "listing[images]"

      assert_select "input[name=?]", "listing[outright_price]"

      assert_select "input[name=?]", "listing[negotiable]"

      assert_select "input[name=?]", "listing[quantity]"

      assert_select "input[name=?]", "listing[deliverable]"

      assert_select "input[name=?]", "listing[listing_fee_id]"
    end
  end
end
