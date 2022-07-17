class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :listing, null: false, foreign_key: true
      t.bigint :cart_num
      t.references :delivery_fee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
