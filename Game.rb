require_relative 'DecodingBoard.rb'
require_relative 'HumanBreaker.rb'
require_relative 'ComputerMaker.rb'
require_relative 'ComputerBreaker.rb'
require 'colorize'

# Mastermind Game
class Game
  attr_accessor :turn
  def initialize(human_name = 'Human')
    @human_breaker = HumanBreaker.new(human_name)
    @cpu_maker = ComputerMaker.new
    @game_board = DecodingBoard.new
    @turn = 1
  end

  def new_game
    game_start
    while @turn < 13
      game_turn(@turn, @cpu_maker.pattern)
      win_check(@cpu_maker.feedback)
      lose_check(@turn, @cpu_maker.feedback)
      @turn += 1
    end
  end

  private

  def game_start
    puts ''
    puts "welcome to mastermind, #{@human_breaker.name}! use the blocks below as a guide for making guesses"
    puts ''
    poss_colors
    @game_board.full_view
    @game_board.set_pattern(@cpu_maker.pattern)
    @game_board.full_view
  end

  def game_turn(turn, pattern)
    guess = @human_breaker.guess_pattern
    @cpu_maker.feedback = @cpu_maker.give_feedback(guess, pattern)
    @game_board.update_guess(turn, guess)
    @game_board.update_feedback(turn, @cpu_maker.feedback, guess)
    @game_board.hidden_view
  end
  
  def win_check(feedback)
    if win_condition(feedback)
      @game_board.full_view
        print "congrats #{@human_breaker.name}! you've guessed the correct pattern!" + "\n"
        @turn = 12
    end
  end

  def lose_check(turn, feedback)
    if turn == 12 && !win_condition(feedback)
      print "you've failed to guess the pattern. try again, #{@human_breaker.name}" 
      @game_board.full_view
    end
  end

  def win_condition(feedback)
    feedback.all? { |word| word == 'red'} && feedback.length == 4
  end

  def poss_colors
    colors = ['']
    for i in 0..139
      colors[0] += ' '
    end
    b = '| B - ' + '  '.colorize(background: :blue)
    c = '| C - ' + '  '.colorize(background: :cyan)
    g = '| G - ' + '  '.colorize(background: :green)
    m = '| M - ' + '  '.colorize(background: :magenta)
    r = '| R - ' + '  '.colorize(background: :light_red)
    y = '| Y - ' + '  '.colorize(background: :yellow)
    colors[0][0] = b
    colors[0][23] = c
    colors[0][46] = g
    colors[0][69] = m
    colors[0][92] = r
    colors[0][116] = y
    colors[0][139] = '|'
    colors[0][141] = 'example guess: BCGR |'
    puts colors
  end
end

x = Game.new
x.new_game
