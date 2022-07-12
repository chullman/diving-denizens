class AddUserToAddresses < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :user, null: true, foreign_key: true
  end
end
