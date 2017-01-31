require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]



    url = "https://api.darksky.net/forecast/3927a8141d640de311ddf20de59bfa12/" + @lat + "," + @lng
    parsed_data = JSON.parse(open(url).read)






    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

# Example api call 3927a8141d640de311ddf20de59bfa12
 # https://api.darksky.net/forecast/3927a8141d640de311ddf20de59bfa12/37.8267,-122.4233


    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours =     parsed_data["hourly"]["summary"]

    @summary_of_next_several_days =  parsed_data["daily"]["summary"]


    render("forecast/coords_to_weather.html.erb")
  end
end
