require_relative 'DecodingBoard.rb'
require_relative 'HumanBreaker.rb'
require_relative 'HumanMaker.rb'
require_relative 'ComputerMaker.rb'
require_relative 'ComputerBreaker.rb'
require 'colorize'
require 'io/console'
require 'pry'

# Mastermind Game
class Game
  attr_accessor :turn, :maker, :breaker, :pattern, :guesses
  def initialize(human_name = 'Human')
    @human_breaker = HumanBreaker.new(human_name)
    @human_maker = HumanMaker.new
    @cpu_maker = ComputerMaker.new
    @cpu_breaker = ComputerBreaker.new
    @game_board = DecodingBoard.new
    @maker = []
    @breaker = []
    @turn = 1
    @guesses = []
  end

  def new_game
    game_start
    while @turn < 13
      game_turn(@turn, @pattern)
      win_check(@maker.feedback)
      lose_check(@turn, maker.feedback)
      @turn += 1
    end
  end

  private

  def game_start
    puts ''
    puts '                                         MASTERMIND                                         '.colorize(:cyan).on_white.underline
    puts ''
    type = select_game
    set_players(type)
    puts ''
    poss_colors
    @game_board.full_view
    if @maker == @human_maker
      @pattern = @maker.select_pattern
    else
      @pattern = @maker.pattern
    end
    @game_board.set_pattern(@pattern)
  end

  def select_game
    dashes = "                                         -------------------"
    puts "please select your preferred game type - | maker | breaker | - and then press enter to play!"
    puts dashes
    puts "                                   [1] - | human |   cpu   |"
    puts dashes
    puts "                                   [2] - |  cpu  |  human  |"
    puts dashes
    puts "                                   [3] - | human |  human  |"
    puts dashes
    puts "                                   [4] - |  cpu  |   cpu   |"
    puts dashes
    type = STDIN.noecho(&:gets).chomp.to_i
    type
  end  

  def set_players(type)
    case type

    when 1
      @maker = @human_maker
      @breaker = @cpu_breaker
    when 2
      @maker = @cpu_maker
      @breaker = @human_breaker
    when 3
      @maker = @human_maker
      @breaker = @human_breaker
    when 4
      @maker = @cpu_maker
      @breaker = @cpu_breaker

    end
  end

  def poss_colors
    colors = ['']
    for i in 0..139
      colors[0] += ' '
    end
    a = '| color guide |'
    b = '| B - ' + '  '.colorize(background: :blue)
    c = '| C - ' + '  '.colorize(background: :cyan)
    g = '| G - ' + '  '.colorize(background: :green)
    m = '| M - ' + '  '.colorize(background: :magenta)
    r = '| R - ' + '  '.colorize(background: :light_red)
    y = '| Y - ' + '  '.colorize(background: :yellow)
    colors[0][0] = a
    colors[0][14] = b
    colors[0][37] = c
    colors[0][60] = g
    colors[0][83] = m
    colors[0][106] = r
    colors[0][130] = y
    colors[0][153] = '|'
    colors[0][155] = 'example guess: BCGR |'
    puts colors
  end

  def game_turn(turn, pattern)
    if @turn == 1
      guess = @breaker.first_pattern
    else
      guess = @breaker.guess_pattern(@guesses[@turn - 2], maker.feedback)
    end
    @guesses.push(guess)
    @maker.feedback = @maker.give_feedback(guess, pattern)
    @game_board.update_guess(turn, guess)
    sleep(3)
    @game_board.update_feedback(turn, @maker.feedback, guess)
    @game_board.hidden_view
  end
  
  def win_check(feedback)
    if win_condition(feedback)
      @game_board.full_view
        print "congrats #{@breaker.name}! you've guessed the correct pattern!" + "\n"
        puts ''
        @turn = 12
    end
  end

  def lose_check(turn, feedback)
    if turn == 12 && !win_condition(feedback)
      print "you've failed to guess the pattern. try again, #{@breaker.name}" 
      p ''
      @game_board.full_view
    end
  end

  def win_condition(feedback)
    feedback.all? { |word| word == 'red'} && feedback.length == 4
  end

end

x = Game.new
x.new_game
