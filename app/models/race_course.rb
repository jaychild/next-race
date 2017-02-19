class RaceCourse < ApplicationRecord
  has_many :races, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: true
end
