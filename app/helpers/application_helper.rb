module ApplicationHelper
	def weather_for_city
		Rails.cache.fetch("weather_cochabamba", expires_in: 10.minutes) do
			api_key = "593789e41fab1f0455acf6d25fc30697"

		    response = Faraday.get("https://api.openweathermap.org/data/2.5/weather", {
		      q: "cochabamba",
		      appid: api_key,
		      units: "metric"
		    })

		    if response.success?
		      data = JSON.parse(response.body)
		      temp = data.dig("main", "temp")
		      desc = data.dig("weather", 0, "description")
		      "#{temp.round(1)}°C"
		    else
		      "Weather unavailable"
		    end
		end
	end
end

 