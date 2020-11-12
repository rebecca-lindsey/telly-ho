class Show
  attr_accessor :name, :summary, :premier_date, :status, :schedule, :network, :web_channel, :episodes_airing, :genre, :type

  @@all = []
  @@genres = []
  @@types = []

  def initialize(name:, genre: 'Unlisted', type: 'Unlisted')
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
end
