class Cli
  attr_accessor :date

  def initialize
    @@date = nil
  end

  def self.start
    puts 'Welcome to Telly-Ho! Here to help your hunt for your next TV show.'
    choose_date
  end

  def self.choose_date
    puts 'Please choose a date with this format: yyyy:mm:dd (ex. 2020:05:25)'
    puts "Or, if you want to choose from shows airing today, just enter 'today'"
    input = gets.strip
    @date = Date.today.strftime if input == 'today'
    Api.new(@date)
    choose_type_welcome
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
      choose_genre_welcome
    else puts 'Please enter one of the below options'
    end
  end

  def self.choose_genre_welcome
    puts 'What genre are you interested in?'
    first_genre_set
  end

  def self.first_genre_set
    puts '1. Action'
    puts '2. Children'
    puts '3. Comedy'
    puts '4. Crime'
    puts '5. Drama'
    puts '6. Family'
    puts '7. Fantasy'
    puts '8. Food'
    puts '9. History'
    puts '10. See More'

    input = gets.strip
    case input
    when '1', 'action'
      Show.list_shows_by_genre('Action')
    when '2', 'children'
      Show.list_shows_by_genre('Children')
    when '3', 'comedy'
      Show.list_shows_by_genre('Comedy')
    when '4', 'crime'
      Show.list_shows_by_genre('Crime')
    when '5', 'drama'
      Show.list_shows_by_genre('Drama')
    when '6', 'family'
      Show.list_shows_by_genre('Family')
    when '7', 'fantasy'
      Show.list_shows_by_type('Fantasy')
    when '8', 'food'
      Show.list_shows_by_type('Food')
    when '9', 'history'
      Show.list_shows_by_type('History')
    when '10'
      second_genre_set
    else Show.list_shows_by_genre(input)
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
end
