# stores API address information
class Config::RaceApi < ApplicationRecord
  delegate :poll_api, :kill_threads, to: :api_tracker_instance

  validates :key, uniqueness: true
  validates_presence_of :key, :url
  validate :next_race_key_validation

  NEXT_RACE_KEY = 'next_race'

  after_save :start_tracking

  # retrieves the API address for the next_race information
  def self.next_race_url
    Config::RaceApi.where(key: NEXT_RACE_KEY).pluck(:url)[0]
  end

  def self.next_race_live_update_active?
    Config::RaceApi.where(key: NEXT_RACE_KEY).pluck(:live_update)[0]
  end

  private

  # gets the single instance of the web_api_tracker
  def api_tracker_instance
    @api_tracker_instance ||= WebApi::Tracker.instance
  end

  # initiates the deamon process if the live_update attribute is set to true
  def start_tracking
    if self.live_update?
      poll_api(self)
    else
      kill_threads
    end
  end

  # make sure the user submits the expected next_race key
  def next_race_key_validation
    return true if self.key == 'next_race'
    self.errors.add(:key, "must specify 'next_race' as API key")
    false
  end
end
