class Api
  attr_accessor :date, :show_list

  def initialize(date)
    @date = date
    @show_list = nil
    fetch_shows_by_date
  end

  def fetch_shows_by_date
    url = "http://api.tvmaze.com/schedule?country=US&date=#{@date}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @show_list = JSON.parse(response)
    create_shows
  end

  def create_shows
    @show_list.each do |show_hash|
      show_instance = Show.new(name: show_hash['show']['name'])
      show_instance.summary = show_hash['show']['summary']
      show_instance.premier_date = show_hash['show']['premiered']
      show_instance.status = show_hash['show']['status']
      show_instance.schedule = [show_hash['show']['schedule']['time'], show_hash['show']['schedule']['days']]
      show_instance.network = show_hash['show']['network']['name']
      show_instance.web_channel = show_hash['show']['webChannel']
      show_instance.genre = show_hash['show']['genres']
    end
  end
end

# airtime - runtime - summary - show
# With show: name - status - premiered - schedule - rating - network - webChannel -summary

# show_name:, show_summary:, show_premier_date:, show_status:, show_schedule:, network:, web_channel:, episodes_airing:

# array_of_drinks.each do |drink_hash|
#             # initialize a new drink
#             drink_instance = Drink.new
#             drink_instance = Drink.new(id: drink_hash["idDrink"], name: drink_hash["strDrink"])
#             # assign attributes to it
#             drink_instance.id = drink_hash["idDrink"]
#             drink_instance.name = drink_hash["strDrink"]
#             drink_instance.instructions = drink_hash["strInstructions"]
#             drink_instance.glass = drink_hash["strGlass"]
#             drink_instance.category = drink_hash["strCategory"]
#         end
