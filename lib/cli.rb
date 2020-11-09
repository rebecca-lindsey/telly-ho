class Cli
  attr_accessor :date

  def initialize
    @date = nil
  end

  def start
    puts 'Welcome to Telly-Ho! Here to help your hunt for your next TV show.'
    choose_date
  end

  def choose_date
    puts 'Please choose a date with this format: yyyy:mm:dd (ex. 2020:05:25)'
    puts "Or, if you want to choose from shows airing today, just enter 'today'"
    input = gets.strip
    @date = Date.today.strftime if input == 'today'
    Api.new(@date)
  end
end