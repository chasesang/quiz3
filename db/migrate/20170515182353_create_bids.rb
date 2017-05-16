class CreateBids < ActiveRecord::Migration[5.0]
  def change
    create_table :bids do |t|
      t.float :price
      t.references :auction, foreign_key: true

      t.timestamps
    end
  end
end
