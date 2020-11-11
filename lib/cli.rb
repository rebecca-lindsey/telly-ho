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
    puts 'Please choose a date with this format: yyyy:mm:dd (ex. 2020:05:25)'
    puts "Or, if you want to choose from shows airing today, just enter 'today'"
    input = gets.strip
    if input == 'today'
      @date = Date.today.strftime
    elsif input.downcase == 'exit'
      exit_message
    end
    Api.new(@date)
    self.class.choose_type_welcome
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity

  def self.choose_type_welcome
    puts 'What type of show would you like to watch?'
    choose_type
  end

  def self.choose_type
    puts '1. Animated'
    puts '2. Documentary'
    puts '3. Game Show'
    puts '4. News'
    puts '5. Reality'
    puts '6. Sports'
    puts '7. Talk Show'
    puts '8. Search all other shows by genre'

    input = gets.strip.downcase
    case input
    when '1', 'animated'
      Show.list_shows_by_type('Animated')
    when '2', 'documentary'
      Show.list_shows_by_type('Documentary')
    when '3', 'game show'
      Show.list_shows_by_type('Game Show')
    when '4', 'news'
      Show.list_shows_by_type('News')
    when '5', 'reality'
      Show.list_shows_by_type('Reality')
    when '6', 'sports'
      Show.list_shows_by_type('Sports')
    when '7', 'talk show'
      Show.list_shows_by_type('Talk Show')
    when '8', 'genre', 'search all other shows by genre'
      genre_selection_welcome
    else puts 'Please enter one of the below options'
    end
  end

  def self.genre_selection_welcome
    puts 'What genre are you interested in?'
    genre_selection_screen
  end

  def self.genre_selection_screen
    Show.genres.sort.each_with_index { |category, index| puts "#{index + 1}. #{category}" }
    genre_selection_validation
  end

  def self.genre_selection_validation
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

  def self.second_genre_set
    puts '10. Legal'
    puts '11. Medical'
    puts '12. Music'
    puts '13. Mystery'
    puts '14. Nature'
    puts '15. Romance'
    puts '16. Science-Fiction'
    puts '17. Supernatural'
    puts '18. Thriller'
    puts '19. Travel'
    puts '20. See first list'

    input = gets.strip
    case input
    when '20'
      first_genre_set
    else Show.list_shows_by_genre(input)
    end
  end

  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity

  def exit_message
    puts 'Thank you for using Telly-Ho! Happy Watching '
    exit
  end
end
