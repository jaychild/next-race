require 'singleton'
require 'thread'

# singleton so that multiple threads aren't instantiated, allowing me to track my children. . .
class WebApi::Tracker
  include Singleton

  INTERFACE = WebApi::TrackerInterface
  SEMAPHORE = Mutex.new
  CYCLE_TIME = 60 # seconds
  attr_accessor :threads

  # initialize with an empty collection of threads
  def initialize
    @threads = []
  end

  # Threading in Ruby is not elegant
  def poll_api(api)
    # blocks the creation of additional threads. Only one live tracker thread may exist at a time,
    # so that the external API is only requested once per minute
    return false if live_thread?

    # create an interface, so that we don't communicate with the processing of data directly. Tracker,
    # is only concerned with retrieving information and passing it on.
    interface = INTERFACE.new(api.key)

    # start a thread and add it to singleton collection
    threads << Thread.new{
      key = api.key
      klass = api.class
      live = true

      # looping once per minute for the API and passing it onto the interface.
      while live do
        # this isn't really required here, but just to protect against the main thread and tracker thread
        # from accessing the database resources simultaneously.
        SEMAPHORE.synchronize {
          interface.track_resource
          live = active_tracking?(klass, key)
        }
        # sleep for N seconds - would some sort of smart scheduling be better or overkill? hmmm...
        sleep(CYCLE_TIME)
      end
    }
    # what to do in case of emergency. . .
  rescue Exception => e
    # api = api.class.where(key: api.key).first
    # deactivate live update of the resource
    api.live_update = false
    api.save
  end

  # kills all the threads and removes them from the collection
  def kill_threads
    threads.each{|thread| thread.terminate}
    self.threads = []
  end

  private

  # returns true if there's a live thread (include sleeping giants)
  def live_thread?
    threads.any?(&:alive?)
  end

  # returns true if the supplied resource has active tracking enabled.
  def active_tracking? klass, key
    klass.where(key: key).pluck(:live_update).first
  end
end
