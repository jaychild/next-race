class NextRaceController < ApplicationController
  after_filter :respond

  def index
    @race = Race.next_race
    @runners = @race.runners.order_by_odds
    @course = @race.race_course
  end

  private

  def respond
    respond_to do |format|
      format.html
      format.js
    end
  end

end
