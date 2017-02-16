class Runner < ApplicationRecord
  has_many :race_runners
  has_many :races, through: :race_runners
end
