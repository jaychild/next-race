module WebApi::RequestLogger
  MODEL = Logger::ApiRequestLogger

  def log_failure(error, id, request, response, code, msg)
    MODEL.create(
        api_request: request,
        api_response: response,
        api_id: id,
        api_errors: error,
        code: code,
        message: msg
    )
  end
end