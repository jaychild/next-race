module Calculations::FurlongConversion
  METER_TO_FURLONG = 201.168

  # converts meters to furlongs to 2dp
  def metres_to_furlongs(m)
    (m / METER_TO_FURLONG).round(2)
  end
end