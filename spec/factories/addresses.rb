FactoryBot.define do
  factory :address do
    first_name { "MyString" }
    last_name { "MyString" }
    unit_type { "MyString" }
    unit_num { 1 }
    lvl_type { "MyString" }
    lvl_num { 1 }
    street_type { "MyString" }
    street_num { 1 }
    street_name { "MyString" }
    suburb { "MyString" }
    postcode { nil }
  end
end
