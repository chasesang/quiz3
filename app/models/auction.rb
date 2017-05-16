class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy

  has_many :watches, dependent: :destroy
  has_many :watchers, through: :watches, source: :user
  validates :title, presence: true
  validates :details, presence: true
  validates :end_date, presence: true
  validates :reserve_price, presence: true
  # validates :current_price, presence: true

  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :reserve_met
    state :won
    state :cancelled
    state :reserve_not_met

    event :publish do
      transitions from: :draft, to: :published
    end

    event :meet do
      transitions from: [:published, :reserve_not_met], to: :reserve_met
    end

    event :unmeet do
      transitions from: [:published, :reserve_met], to: :reserve_not_met
    end

    event :win do
      transitions from: [:published, :reserve_met], to: :won
    end

    event :cancel do
      transitions from: [:published, :reserve_met, :reserve_not_met, :won], to: :cancelled
    end

    event :relaunch do
      transitions from: :cancelled, to: :draft
    end

  end

  def watched_by?(user)
    watches.exists?(user:user)
  end

  def watch_for(user)
    watches.find_by(user:user)
  end


end
