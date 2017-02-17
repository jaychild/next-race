class Race < ApplicationRecord
  include Calculations::FurlongConversion
  include Calculations::TimeConversion

  belongs_to :race_course
  has_many :race_runners
  has_many :runners, through: :race_runners

  scope :next_race, -> { order(:requested_at).last }

  def furlongs
    metres_to_furlongs(self.distance)
  end

  def local_time
    pretty_local_time(self.time)
  end

  def minutes_to_start
    minutes_until_start(self.time)
  end
end
