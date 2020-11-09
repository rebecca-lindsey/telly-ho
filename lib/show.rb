class Show
  attr_accessor :name, :summary, :premier_date, :status, :schedule, :network, :web_channel, :episodes_airing, :genre, :type

  @@all = []
  @@uniq_show_names = []

  def initialize(name:)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  def self.list_all_shows
    uniq_show_names = []
    @@all.map do |show|
      @@uniq_show_names << show.name unless @@uniq_show_names.include?(show.name)
    end
    @@uniq_show_names.sort.each_with_index { |show, index| puts "#{index + 1}. #{show}" }
  end

  def self.list_shows_by_genre(genre)
    genre_arr = []
    @@all.each do |show|
      if show.genre.any?(genre)
        genre_arr << show
        puts "#{genre_arr.length}. #{show.name}"
      end
    end
  end
end
# airtime - runtime - summary - show
# With show: name - status - premiered - schedule - rating - network - webChannel -summary
