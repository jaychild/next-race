# stores API address information
class Configuration::RaceApi < ApplicationRecord
  validates :key, uniqueness: true
  validates_presence_of :key, :url

  NEXT_RACE_KEY = 'next_race'

  # retrieves the API address for the next_race information
  def self.next_race_url
    Configuration::RaceApi.where(key: NEXT_RACE_KEY).pluck(:url)[0]
  end

  def self.next_race_live_update_active?
    Configuration::RaceApi.where(key: NEXT_RACE_KEY).pluck(:live_update)[0]
  end
end
