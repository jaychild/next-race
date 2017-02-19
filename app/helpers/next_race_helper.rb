module NextRaceHelper

  # returns true if the latest race time is 10 minutes or more in the past
  def no_scheduled_race(race)
    return true if race.is_a? ActiveRecord::Relation
    time = race.time
    time.localtime < (Time.now - 10.minutes)
  end

end
