class WebApi::TrackerInterface
  API_KEY_MAP = {
      next_race: {
          service: WebApi::NextRace::Service,
          method: :request_next_race
      }
  }

  def initialize(key)
    @key = key
  end

  def track_resource
    service = API_KEY_MAP[key.to_sym]
    object = service[:service].new
    object.send(service[:method])
  end

  private
  attr_reader :key
end