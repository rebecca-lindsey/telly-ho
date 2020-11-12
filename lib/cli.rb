# rubocop:disable Metrics/ClassLength

class Cli
  attr_accessor :date

  def initialize
    @@date = nil
  end

  def start
    puts 'Welcome to Telly-Ho! Here to help your hunt for your next TV show.'.colorize(:blue)
    puts ''
    puts "At any time, enter 'exit' to exit Telly-Ho"
    puts ''
    choose_date
  end

  def choose_date
    puts 'Search for any date this year by entering: mm-dd (ex. 05-25)'.colorize(:green)
    puts "Or, if you want to choose from shows airing today, just enter 'today'".colorize(:green)
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
    Show.types.sort.each_with_index { |category, index| puts "#{index + 1}. #{category}".colorize(:yellow) }
    if Show.types.length == 0
      genre_selection_screen
    else
      puts "#{Show.types.length + 1}. Select all other shows by genre".colorize(:magenta)
      type_selection_validation
    end
  end

  # rubocop:disable Metrics/AbcSize

  def type_selection_validation
    input = gets.strip
    if input.to_i.positive? && input.to_i <= Show.types.length
      category = Show.types.sort[input.to_i - 1]
      list_shows_by_type(category)
    elsif Show.types.sort.include?(input.capitalize)
      list_shows_by_type(input.capitalize)
    elsif input.to_i == Show.types.length + 1 || input.downcase == 'genre'
      genre_selection_welcome
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
    Show.genres.sort.each_with_index { |category, index| puts "#{index + 1}. #{category}".colorize(:yellow) }
    if Show.genres.length == 0
      puts 'There are no available genres!'
      type_selection_welcome
    else
      puts "#{Show.genres.length + 1}. Return to type menu".colorize(:magenta)
      genre_selection_validation
    end
  end
  # rubocop:disable Metrics/AbcSize

  def genre_selection_validation
    input = gets.strip
    if input.to_i.positive? && input.to_i <= Show.genres.length
      category = Show.genres.sort[input.to_i - 1]
      list_shows_by_genre(category)
    elsif Show.genres.sort.include?(input.capitalize)
      list_shows_by_genre(input.capitalize)
    elsif input.to_i == Show.genres.length + 1 || input.downcase == 'genre'
      type_selection_welcome
    elsif input.downcase == 'exit'
      exit_message
    else
      puts 'That is not a valid input! Please choose one of the listed genres:'
      genre_selection_screen
    end
  end

  # rubocop:enable Metrics/AbcSize

  def genre_select_show_validation(list)
    input = gets.strip
    if input.to_i.positive? && input.to_i <= list.length
      display_show(list[input.to_i - 1])
    elsif input.to_i == list.length + 1 || input.downcase == 'back'
      genre_selection_welcome
    elsif input.downcase == 'exit'
      exit_message
    else
      puts 'Invalid input!'
      list_shows_by_genre(list[0].genre.join(''))
    end
  end

  def type_select_show_validation(list)
    input = gets.strip
    if input.to_i.positive? && input.to_i <= list.length
      display_show(list[input.to_i - 1])
    elsif input.to_i == list.length + 1 || input.downcase == 'back'
      type_selection_welcome
    elsif input.downcase == 'exit'
      exit_message
    else
      puts 'Invalid input!'
      list_shows_by_type(list[0].type.join(''))
    end
  end

  def return_options
    puts "Enter 'new date' to restart your search on a new date".colorize(:green)
    puts "Or, enter 'more shows' to search for more shows on #{@@date}".colorize(:green)
    puts "If you've found your show, enter 'exit' to leave Telly-Ho".colorize(:green)
    return_options_validation
  end

  def return_options_validation
    input = gets.strip
    case input.downcase
    when 'new date'
      cli = Cli.new
      cli.start
    when 'more shows'
      type_selection_welcome
    when 'exit'
      exit_message
    else
      return_options
    end
  end

  def exit_message
    puts 'Thank you for using Telly-Ho! Happy Watching '.colorize(:blue)
    exit
  end

  # rubocop:disable Layout/LineLength

  def list_shows_by_type(type)
    puts 'Please enter the number for the show you would like more info on:'
    type_list = Show.all.filter { |show| show.type == type }.sort_by(&:name).uniq(&:name).each_with_index { |show, index| puts "#{index + 1}. #{show.name}".colorize(:yellow) }
    puts "#{type_list.length + 1}. Back to type list".colorize(:magenta)
    type_select_show_validation(type_list)
  end

  def list_shows_by_genre(genre)
    puts 'Please enter the number for the show you would like more info on:'
    genre_list = Show.all.filter { |show| show.genre.any?(genre) unless show.genre.nil? }.sort_by(&:name).uniq(&:name).each_with_index { |show, index| puts "#{index + 1}. #{show.name}".colorize(:yellow) }
    puts "#{genre_list.length + 1}. Back to genre list".colorize(:magenta)
    genre_select_show_validation(genre_list)
  end
  # rubocop:enable Layout/LineLength

  # def access_show_info(name)
  #   Show.all.filter { |show| show.name == name }
  # end

  def display_show(show)
    puts show.name.to_s.colorize(:blue).bold
    puts "Status: #{show.status}"
    puts "Premier date: #{show.premier_date}"
    puts "Genre: #{show.genre.join(', ')}"
    if show.schedule[0] == '00:00' && !show.schedule[1].empty?
      puts "Scheduled on: #{show.schedule[1].join(', ')}"
    elsif !show.schedule[1].empty?
      puts "Air time: #{show.schedule[0]} on #{show.schedule[1].join(', ')}"
    else puts 'Schedule: To be detemined'
    end
    puts "Network: #{show.network}"
    puts 'Summary: '.colorize(:magenta)
    puts show.summary.to_s.gsub(%r{<\w*>|</\w>}, '').to_s
    puts ''
    return_options
  end
end
# rubocop:enable Metrics/ClassLength
