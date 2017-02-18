class Race < ApplicationRecord
  include Calculations::FurlongConversion
  include Calculations::TimeConversion

  belongs_to :race_course
  has_many :race_runners
  has_many :runners, through: :race_runners

  # scope :next_race, -> { order(:requested_at).last }
  scope :next_race, -> { joins(:race_course).select('races.distance, races.time, races.id, race_courses.name').order(:requested_at).last}

  def furlongs
    self.distance.blank? ? '' : metres_to_furlongs(self.distance)
  end

  def local_time
    self.time.blank? ? '' : pretty_local_time(self.time)
  end

  def minutes_to_start
    self.time.blank? ? '' : minutes_until_start(self.time)
  end
end
