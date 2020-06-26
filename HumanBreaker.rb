

# Human CodeBreaker
class HumanBreaker
  @@COLOR_KEY = {
    _: 'black',
    b: 'blue',
    c: 'cyan',
    g: 'green',
    r: 'light_red',
    m: 'magenta',
    y: 'yellow'
  }
  attr_reader :name
  def initialize(name = 'Human')
    @name = name
  end

  def guess_pattern()  # transforms 4 character guess into array of strings representing colors
    print "enter your guess, #{@name}: "
    guess = gets.chomp
    guess = check_guess(guess)
    string_to_array(guess)
  end

  private

  def check_guess(guess)
    count = 0
    while count < 4
      if !@@COLOR_KEY.key?(:"#{guess[count]}") || guess.length != 4
        print "invalid guess, try again #{@name}: "
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
end


