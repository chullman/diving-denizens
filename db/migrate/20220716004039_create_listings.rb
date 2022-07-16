class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.decimal :outright_price
      t.boolean :negotiable
      t.integer :quantity
      t.boolean :deliverable
      t.references :listing_fee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
