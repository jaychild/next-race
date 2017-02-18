require 'singleton'
require 'thread'

# singleton so that multiple threads aren't instantiated, allowing me to track my children. . .
class WebApi::Tracker
  include Singleton

  INTERFACE = WebApi::TrackerInterface
  SEMAPHORE = Mutex.new
  CYCLE_TIME = 60 # seconds
  attr_accessor :threads

  def initialize
    @threads = []
  end

  # Threading in Ruby is not elegant
  def poll_api(api)
    interface = INTERFACE.new(api.key)
    threads << Thread.new{
      key = api.key
      klass = api.class
      live = true
      while live do
        SEMAPHORE.synchronize {
          interface.track_resource
          live = active_tracking?(klass, key)
        }
        sleep(CYCLE_TIME)
      end
    }
  rescue Exception => e
    api = klass.where(key: key).first
    api.live_update = false
    api.save
    raise e.inspect
  end

  private

  def active_tracking? klass, key
    klass.where(key: key).pluck(:live_update).first
  end
end
