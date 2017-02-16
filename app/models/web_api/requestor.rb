class WebApi::Requestor
  require 'net/http'

  def initialize(url, data='')
    @url = url
    @data = data
  end

  def self.get_resource
    uri = URI(url + data)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  rescue
    {'status' => 'could not establish connection to api.'}
  end

  private
  attr_reader :url, :data
end