class Show
  attr_accessor :name, :summary, :premier_date, :status, :schedule, :network, :web_channel, :episodes_airing, :genre

  @@all = []

  def initialize(name:)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  def self.list_shows
    uniq_show_names = []
    @@all.map do |show|
      uniq_show_names << show.name unless uniq_show_names.include?(show.name)
    end
    uniq_show_names.sort.each_with_index { |show, index| puts "#{index + 1}. #{show}" }
    binding.pry
  end
end
# airtime - runtime - summary - show
# With show: name - status - premiered - schedule - rating - network - webChannel -summary
