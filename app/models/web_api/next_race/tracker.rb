require 'singleton'
class WebApi::NextRace::Tracker
  include Singleton

  delegate :get_resource, to: :next_race_interface
  delegate :next_race_live_update_active?, to: Configuration::RaceApi

  def initialize
    @observers = []
    @json = {}
    @thread = nil
  end

  def add_observer(observer)
    observers << observer
  end

  def track_next_race
    if next_race_live_update_active?
      self.thread = Thread.new{
        while next_race_live_update_active? do
          self.json = get_resource



          notify
          sleep(60)
        end
      }

    end
  end

  private
  attr_accessor :observers, :json, :thread

  def next_race_interface
    @next_race_interface ||= WebApi::NextRace::Service.new
  end

  def notify
    observers.each do |observer|
      observer.update(self.json)
    end
  end

end
