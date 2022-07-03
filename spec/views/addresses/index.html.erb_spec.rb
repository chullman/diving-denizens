require 'rails_helper'

RSpec.describe "addresses/index", type: :view do
  before(:each) do
    assign(:addresses, [
      Address.create!(
        first_name: "First Name",
        last_name: "Last Name",
        unit_type: "Unit Type",
        unit_num: 2,
        lvl_type: "Lvl Type",
        lvl_num: 3,
        street_type: "Street Type",
        street_num: 4,
        street_name: "Street Name",
        suburb: "Suburb",
        postcode: nil
      ),
      Address.create!(
        first_name: "First Name",
        last_name: "Last Name",
        unit_type: "Unit Type",
        unit_num: 2,
        lvl_type: "Lvl Type",
        lvl_num: 3,
        street_type: "Street Type",
        street_num: 4,
        street_name: "Street Name",
        suburb: "Suburb",
        postcode: nil
      )
    ])
  end

  it "renders a list of addresses" do
    render
    assert_select "tr>td", text: "First Name".to_s, count: 2
    assert_select "tr>td", text: "Last Name".to_s, count: 2
    assert_select "tr>td", text: "Unit Type".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Lvl Type".to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Street Type".to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: "Street Name".to_s, count: 2
    assert_select "tr>td", text: "Suburb".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
