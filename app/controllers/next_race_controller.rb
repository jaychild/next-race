class NextRaceController < ApplicationController
  after_filter :respond

  def index
    race = Race.next_race
    @course = race.name
    @distance = race.is_a?(ActiveRecord::Relation) ? '' : race.furlongs
    @time = race.is_a?(ActiveRecord::Relation) ? '' : race.local_time
    @countdown = race.is_a?(ActiveRecord::Relation) ? '' : race.minutes_to_start
    @runners = race.is_a?(ActiveRecord::Relation) ? [] : race.runners.order_by_odds
  end

  private

  def respond
    respond_to do |format|
      format.html
      format.js
    end
  end

end
