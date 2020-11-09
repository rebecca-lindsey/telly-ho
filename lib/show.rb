class Show
  attr_accessor :name, :summary, :premier_date, :status, :schedule, :network, :web_channel, :episodes_airing

@@all = []

  def initialize(name:)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end
end
# airtime - runtime - summary - show
# With show: name - status - premiered - schedule - rating - network - webChannel -summary
