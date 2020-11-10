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
    uniq_show_names = []
    @@all.map do |show|
      @@uniq_show_names << show.name unless @@uniq_show_names.include?(show.name)
    end
    @@uniq_show_names.sort.each_with_index { |show, index| puts "#{index + 1}. #{show}" }
  end

  # rubocop:disable Layout/LineLength

  def self.list_shows_by_type(type)
    @@all.filter { |show| show.type == type }.sort_by(&:name).uniq(&:name).each_with_index { |show, index| puts "#{index + 1}. #{show.name}" }
  end

  def self.list_shows_by_genre(genre)
    @@all.filter { |show| show.genre.any?(genre) unless show.genre.nil? }.sort_by(&:name).uniq(&:name).each_with_index { |show, index| puts "#{index + 1}. #{show.name}" }
  end
  # rubocop:enable Layout/LineLength
end
# airtime - runtime - summary - show
# With show: name - status - premiered - schedule - rating - network - webChannel -summary
