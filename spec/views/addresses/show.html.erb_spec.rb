require 'rails_helper'

RSpec.describe "addresses/show", type: :view do
  before(:each) do
    @address = assign(:address, Address.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Unit Type/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Lvl Type/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Street Type/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Street Name/)
    expect(rendered).to match(/Suburb/)
    expect(rendered).to match(//)
  end
end
