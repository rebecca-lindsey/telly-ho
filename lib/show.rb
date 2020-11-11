class Show
  attr_accessor :name, :summary, :premier_date, :status, :schedule, :network, :web_channel, :episodes_airing, :genre, :type

  @@all = []
  @@genres = []
  @@types = []

  def initialize(name:, genre:, type:)
    @name = name
    @genre = genre
    @type = type
    @@all << self
    create_lists
  end

  def create_lists
    genre.each { |item| @@genres << item unless @@genres.include?(item) }
    @@types << type unless @@types.include?(type)
  end

  def self.all
    @@all
  end

  def self.genres
    @@genres
  end

  def self.types
    @@types
  end

  def self.list_all_shows
    @@all.sort_by(&:name).uniq(&:name).each_with_index { |show, index| puts "#{index + 1}. #{show.name}" }
  end

  # rubocop:disable Layout/LineLength

  def self.list_shows_by_type(type)
    show_list = @@all.filter { |show| show.type == type }.sort_by(&:name).uniq(&:name).each_with_index { |show, index| puts "#{index + 1}. #{show.name}" }
    # Cli.select_show_validation(show_list.length)
  end

  def self.list_shows_by_genre(genre)
    genre_list = @@all.filter { |show| show.genre.any?(genre) unless show.genre.nil? }.sort_by(&:name).uniq(&:name).each_with_index { |show, index| puts "#{index + 1}. #{show.name}" }
    Cli.genre_select_show_validation(genre_list)
  end
  # rubocop:enable Layout/LineLength

  def self.access_show_info(name)
    @@all.filter { |show| show.name == name }
  end

  def self.display_show(show)
    puts show.name.to_s.colorize(:blue).bold
    puts "Status: #{show.status}"
    puts "Premier date: #{show.premier_date}"
    puts "Genre: #{show.genre.join(', ')}"
    puts "Air time: #{show.schedule[0]} on #{show.schedule[1].join(', ')}"
    puts "Network: #{show.network}"
    puts 'Summary: '.colorize(:magenta)
    puts show.summary.to_s.gsub(%r{<\w*>|</\w>}, '').to_s
    puts ''
    Cli.return_options
  end
end
# airtime - runtime - summary - show
# With show: name - status - premiered - schedule - rating - network - webChannel -summary
