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
      show_info = show_hash['show']
      show_instance = Show.new(name: show_info['name'], genre: show_info['genres'], type: show_info['type'])
      show_info['summary'].nil? ? show_instance.summary = 'Unlisted' : show_instance.summary = show_info['summary']
      show_info['premiered'].nil? ? show_instance.premier_date = 'Unlisted' : show_instance.premier_date = show_info['premiered']
      show_info['status'].nil? ? show_instance.status = 'Unlisted' : show_instance.status = show_info['status']
      show_info['schedule'].nil? ? show_instance.schedule = 'Unlisted' : show_instance.schedule = [show_info['schedule']['time'], show_info['schedule']['days']]
      show_info['network'].nil? ? show_instance.network = 'Unlisted' : show_instance.network = show_info['network']['name']
    end
  end
end
