require 'rails_helper'

RSpec.describe "addresses/new", type: :view do
  before(:each) do
    assign(:address, Address.new(
      first_name: "MyString",
      last_name: "MyString",
      unit_type: "MyString",
      unit_num: 1,
      lvl_type: "MyString",
      lvl_num: 1,
      street_type: "MyString",
      street_num: 1,
      street_name: "MyString",
      suburb: "MyString",
      postcode: nil
    ))
  end

  it "renders new address form" do
    render

    assert_select "form[action=?][method=?]", addresses_path, "post" do

      assert_select "input[name=?]", "address[first_name]"

      assert_select "input[name=?]", "address[last_name]"

      assert_select "input[name=?]", "address[unit_type]"

      assert_select "input[name=?]", "address[unit_num]"

      assert_select "input[name=?]", "address[lvl_type]"

      assert_select "input[name=?]", "address[lvl_num]"

      assert_select "input[name=?]", "address[street_type]"

      assert_select "input[name=?]", "address[street_num]"

      assert_select "input[name=?]", "address[street_name]"

      assert_select "input[name=?]", "address[suburb]"

      assert_select "input[name=?]", "address[postcode_id]"
    end
  end
end
