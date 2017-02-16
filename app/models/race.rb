class Race < ApplicationRecord
  belongs_to :race_course
  has_many :race_runners
  has_many :runners, through: :race_runners
end
