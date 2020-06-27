# Human CodeBreaker
class HumanBreaker
  @@COLOR_KEY = {
    b: 'blue',
    c: 'cyan',
    g: 'green',
    r: 'light_red',
    m: 'magenta',
    y: 'yellow'
  }
  attr_reader :name, :COLOR_KEY
  def initialize(name = 'Human')
    @name = name
  end

  def guess_pattern()
    print "enter your guess, #{@name}: "
    guess = gets.chomp.downcase
    print "\n"
    guess = check_guess(guess)
    guess = string_to_array(guess)
    char_to_color(guess)
  end

  private

  def check_guess(guess)
    count = 0
    while count < 4
      if !@@COLOR_KEY.key?(:"#{guess[count]}") || guess.length != 4
        print "invalid guess. try again, #{@name}: "
        guess = gets.chomp
        count = 0
      else 
        count += 1
      end
    end
    guess
  end
  
  def string_to_array(guess)
    guess.split('')
  end

  def char_to_color(guess)
    colors = []
    for i in 0..3
      colors.push(@@COLOR_KEY[:"#{guess[i]}"])
    end
    colors
  end
end
