class WebApi::Requestor
  require 'net/http'
  include WebApi::RequestLogger

  def initialize(url, data='')
    @url = url
    @data = data
  end

  def get_resource
    uri = URI(url + data)
    response = Net::HTTP.get_response(uri)
    code = response.code
    msg = response.message

    api_id = Config::RaceApi.where(url: url).pluck(:id).first
    log_failure('', api_id, url, response, code, msg)

    JSON.parse(response.body)
  rescue => e
    api_id = Config::RaceApi.where(url: url).pluck(:id).first
    log_failure(e, api_id, url, response, code, msg)
    {'status' => 'could not establish connection to api.'}
  end

  private
  attr_reader :url, :data
end