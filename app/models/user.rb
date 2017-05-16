class User < ApplicationRecord
  has_secure_password
  has_many :actions, dependent: :nullify
  has_many :bids, dependent: :nullify

  has_many :watches, dependent: :destroy
  has_many :watched_auctions, through: :watches, source: :auction
  

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX
end
