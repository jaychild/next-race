class Runner < ApplicationRecord
  has_many :race_runners
  has_many :races, through: :race_runners

  scope :order_by_odds, -> { order(odds: :desc) }
end
