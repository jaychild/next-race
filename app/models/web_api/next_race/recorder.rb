class WebApi::NextRace::Recorder

  COURSE_MODEL = RaceCourse
  RACE_MODEL = Race
  RUNNER_MODEL = Runner

  def initialize
  end

  def persist_race(params)
    course_hash = {name: params[:course]}
    course = COURSE_MODEL.where(course_hash).first
    if course.nil?
      COURSE_MODEL.new(course_hash)
      return {persisted: false, error: 'could not save or retrieve race course'}
    end

    race = course.races.new(
        time: params[:time],
        distance: params[:distance]
    )

    return {persisted: false, error: 'could not create race information'} unless race.save

    runners = []
    params[:runners].each do |runner|
      runner = RUNNER_MODEL.new(
          number: runner[:number],
          horse_name: runner[:horse_name],
          jockey_name: runner[:jockey_name],
          form: runner[:form],
          odds: runner[:odds]
      )
      runners << runner
    end

    race.runners << runners
    race.requested_at = DateTime.now
    race.save
  end

end