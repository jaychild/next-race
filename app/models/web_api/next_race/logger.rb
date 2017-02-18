module WebApi::NextRace::Logger
  MODEL = Logger::NextRaceLogger

  def log_failure(hash)
    MODEL.create(
        error: hash[:errors],
        logged_at: DateTime.now
    )
  end
end