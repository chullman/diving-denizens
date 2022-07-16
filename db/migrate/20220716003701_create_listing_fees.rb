class CreateListingFees < ActiveRecord::Migration[6.1]
  def change
    create_table :listing_fees do |t|
      t.decimal :fee_price
      t.datetime :valid_from

      t.timestamps
    end
  end
end
