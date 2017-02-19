class WebApi::NextRace::Recorder

  COURSE_MODEL = RaceCourse
  RACE_MODEL = Race
  RUNNER_MODEL = Runner

  def initialize
  end

  def persist_race(params)
    course_hash = create_or_find_course(params['course'])
    return course_hash unless course_hash[:persisted]
    course = course_hash[:object]

    race_hash = create_race(course, params)
    return race_hash unless race_hash[:persisted]
    race = race_hash[:object]

    competitors = create_runners(race, params['runners'])
    race.runners << competitors
    race.requested_at = DateTime.now
    { persisted: race.save, error: race.errors, object: race}
  end

  private

  def create_or_find_course(course_name)
    course = COURSE_MODEL.where(name: course_name).first || COURSE_MODEL.new(name: course_name)
    return {
        persisted: course.save,
        error: course.errors.full_messages,
        object: course
    }
  end

  def create_race(course, params)
    race = course.races.new(
        time: params['time'],
        distance: params['distance']
    )
    return {
        persisted: race.save,
        error: race.errors.full_messages,
        object: race
    }
  end

  def create_runners(race, runners)
    competitors = []
    runners.each do |runner|
      runner = race.runners.new(
          number: runner['number'],
          horse_name: runner['horse_name'],
          jockey_name: runner['jockey_name'],
          form: runner['form'],
          odds: runner['odds']
      )
      competitors << runner
    end
    competitors
  end

end