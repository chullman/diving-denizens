class AddPostcodeToAddresses < ActiveRecord::Migration[6.1]
  def change
    add_column :addresses, :postcode_id, :integer
  end
end
