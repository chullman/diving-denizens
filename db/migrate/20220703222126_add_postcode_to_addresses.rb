class AddPostcodeToAddresses < ActiveRecord::Migration[6.1]
  def change
    add_column :addresses, :postcode, :integer
  end
end
