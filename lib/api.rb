class Api
  attr_accessor :date, :show_list

  def initialize(date)
    @date = date
    @show_list = nil
    find_shows_by_date
  end

  def find_shows_by_date
    url = "http://api.tvmaze.com/schedule?country=US&date=#{@date}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @show_list = JSON.parse(response)
    display_all_shows
  end

  def display_all_shows
    @show_list.each_with_index { |show, index| puts "#{index + 1}. #{show['show']['name']}" }
  end
end

# airtime - runtime - summary - show
# With show: name - status - premiered - schedule - rating - network - webChannel -summary
