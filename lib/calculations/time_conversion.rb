module Calculations::TimeConversion
  # args ActiveSupport::TimeWithZone
  def pretty_local_time(time)
    time.localtime.strftime("%A, %d %b %Y %l:%M %p")
  end

  def minutes_until_start(time)
    minutes = time.localtime.to_i - DateTime.now.localtime.to_i
    minutes/60 >= 0 ? minutes/60 : 0
  end
end