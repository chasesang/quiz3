class AddUserReferencesToAuctions < ActiveRecord::Migration[5.0]
  def change
    add_reference :auctions, :user, foreign_key: true
  end
end
