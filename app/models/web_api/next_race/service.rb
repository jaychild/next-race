class WebApi::NextRace::Service
  include WebApi::NextRace::Logger
  delegate :next_race_url, to: :api_lookup_klass
  delegate :get_resource, to: :requestor_klass
  delegate :persist_race, to: :recorder_klass

  def initialize
    @url = next_race_url
  end

  def request_next_race
    race_json = get_resource
    result = persist_race(race_json)
    log_failure(result) unless result[:persisted]
    result
  end

  private

  attr_reader :url

  def api_lookup_klass
    @api_lookup_klass ||= Config::RaceApi
  end

  def requestor_klass
    @requestor_klass ||= WebApi::Requestor.new(url)
  end

  def recorder_klass
    @recorder_klass ||= WebApi::NextRace::Recorder.new
  end
end