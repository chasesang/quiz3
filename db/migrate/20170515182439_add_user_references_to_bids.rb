class AddUserReferencesToBids < ActiveRecord::Migration[5.0]
  def change
    add_reference :bids, :user, foreign_key: true
  end
end
