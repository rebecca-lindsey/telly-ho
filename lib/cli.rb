class Cli
  attr_accessor :date

  def initialize
    @@date = nil
  end

  def start
    puts 'Welcome to Telly-Ho! Here to help your hunt for your next TV show.'
    choose_date
  end

  def choose_date
    puts 'Search for any date this year by entering: mm-dd (ex. 05-25)'
    puts "Or, if you want to choose from shows airing today, just enter 'today'"
    input = gets.strip
    input.downcase == 'exit' ? exit_message : validate_date(input)
    if !@@date.nil?
      Api.new(@@date)
      type_selection_welcome
    else
      puts 'Invalid Date!'
      choose_date
    end
  end

  def validate_date(input)
    case input
    when 'today'
      @@date = Date.today.strftime
    when /\d{2}-\d{2}/
      split = input.split('-')
      @@date = "#{Date.today.year}-#{input}" if Date.valid_date?(Date.today.year, split[0].to_i, split[1].to_i)
    end
  end

  def type_selection_welcome
    puts 'What type of show would you like to watch?'
    type_selection_screen
  end

  def type_selection_screen
    Show.types.sort.each_with_index { |category, index| puts "#{index + 1}. #{category}" }
    type_selection_validation
  end

  # rubocop:disable Metrics/AbcSize

  def type_selection_validation
    input = gets.strip
    if input.to_i != 0 && input.to_i <= Show.types.length
      category = Show.types.sort[input.to_i - 1]
      Show.list_shows_by_type(category)
    elsif Show.types.sort.include?(input.capitalize)
      Show.list_shows_by_type(input.capitalize)
    elsif input.downcase == 'exit'
      exit_message
    else
      puts 'That is not a valid input! Please choose one of the listed types:'
      type_selection_screen
    end
  end

  # rubocop:enable Metrics/AbcSize

  def genre_selection_welcome
    puts 'What genre are you interested in?'
    genre_selection_screen
  end

  def genre_selection_screen
    Show.genres.sort.each_with_index { |category, index| puts "#{index + 1}. #{category}" }
    genre_selection_validation
  end

  # rubocop:disable Metrics/AbcSize

  def genre_selection_validation
    input = gets.strip
    if input.to_i != 0 && input.to_i <= Show.genres.length
      category = Show.genres.sort[input.to_i - 1]
      Show.list_shows_by_genre(category)
    elsif Show.genres.sort.include?(input.capitalize)
      Show.list_shows_by_genre(input.capitalize)
    elsif input.downcase == 'exit'
      exit_message
    else
      puts 'That is not a valid input! Please choose one of the listed genres:'
      genre_selection_screen
    end
  end

  # rubocop:enable Metrics/AbcSize

  def exit_message
    puts 'Thank you for using Telly-Ho! Happy Watching '
    exit
  end
end
