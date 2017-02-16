class RaceCourse < ApplicationRecord
  has_many :races
  validates :name, presence: true
  validates :name, uniqueness: true
end
