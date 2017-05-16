class AddAasmStateToAuctions < ActiveRecord::Migration[5.0]
  def change
    add_column :auctions, :aasm_state, :string
  end
end
