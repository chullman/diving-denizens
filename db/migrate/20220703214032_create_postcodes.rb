class CreatePostcodes < ActiveRecord::Migration[6.1]
  def change
    create_table :postcodes, id: false do |t|
      t.primary_key :postcode
      t.string :state

      t.timestamps
    end
  end
end
