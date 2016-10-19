require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================

    @url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address_without_spaces}"

    @parsed_data = JSON.parse(open(@url).read)

    @latitude = @parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude =  @parsed_data["results"][0]["geometry"]["location"]["lng"]


    @url = "https://api.darksky.net/forecast/1264187fecc59a1760d2e39efec65e70/#{@latitude},#{@longitude}"

    @parsed_data2 = JSON.parse(open(@url).read)

#@parsed_data["currently"]["summary"]

    @current_temperature = @parsed_data2["currently"]["temperature"]

    @current_summary = @parsed_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_data2["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_data2["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_data2["daily"]["summary"]


    render("meteorologist/street_to_weather.html.erb")
  end
end
