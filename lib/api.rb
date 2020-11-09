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

  # rubocop:disable Metrics/AbcSize

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
      show_instance.type = show_hash['show']['type']
    end
  end
end

# rubocop:enable Metrics/AbcSize

# airtime - runtime - summary - show
