require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    modified_street_address = @street_address.gsub(" ", "+").gsub(" ", "").gsub(".", "")
    url= "https://maps.googleapis.com/maps/api/geocode/json?address=" + modified_street_address + "&sensor=false"
    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    lat = latitude.to_s
    long = longitude.to_s

    url = "https://api.darksky.net/forecast/3927a8141d640de311ddf20de59bfa12/" + lat + "," + long
    parsed_data = JSON.parse(open(url).read)


    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours =     parsed_data["hourly"]["summary"]

    @summary_of_next_several_days =  parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
