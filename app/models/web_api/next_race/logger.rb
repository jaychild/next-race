module WebApi::NextRace::Logger
  MODEL = Logger::NextRaceLogger

  def log_failure(hash)
    MODEL.create(
        error: "object: #{hash[:object].class}, error: #{hash[:error].join(', ')}",
        logged_at: DateTime.now
    )
  end
end