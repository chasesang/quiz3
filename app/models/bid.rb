class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :user
  validates :price, presence: true
end
