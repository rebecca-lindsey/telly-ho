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
      show_instance = Show.new(name: show_hash['show']['name'], genre: show_hash['show']['genres'], type: show_hash['show']['type'])
      show_hash['show']['summary'].nil? ? show_instance.summary = 'Unlisted' : show_instance.summary = show_hash['show']['summary']
      show_hash['show']['premiered'].nil? ? show_instance.premier_date = 'Unlisted' : show_instance.premier_date = show_hash['show']['premiered']
      show_instance.status = (show_hash['show']['status'].nil? ? 'Unlisted' : show_hash['show']['status'])
      show_hash['show']['schedule'].nil? ? show_instance.schedule = 'Unlisted' : show_instance.schedule = [show_hash['show']['schedule']['time'], show_hash['show']['schedule']['days']]
      show_hash['show']['network'].nil? ? show_instance.network = 'Unlisted' : show_instance.network = show_hash['show']['network']['name']
    end
  end
end
