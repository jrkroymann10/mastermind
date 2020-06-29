class HumanMaker
  @@COLOR_KEY = {
    b: 'blue',
    c: 'cyan',
    g: 'green',
    r: 'light_red',
    m: 'magenta',
    y: 'yellow'
  }
  @@COLORS = ['cyan', 'magenta', 'yellow', 'green', 'light_red', 'blue']
  @@FB_COLORS = ['red', 'white']
  attr_accessor :feedback
  attr_reader :COLOR_KEY
  def initialize
    @feedback = []
    @name = 'Human'
  end

  def select_pattern
    print "enter your secret pattern, #{@name}: "
    guess = gets.chomp.downcase
    print "\n"
    guess = check_guess(guess)
    guess = string_to_array(guess)
    guess = char_to_color(guess)
    return guess
  end

  def give_feedback(guess, pattern)
    temp_array = check_red(guess, pattern)
    reduced = reduce(guess, pattern)
    temp_fb = check_white(reduced[0], reduced[1], temp_array[0])
    final_feedback = random_fb(temp_fb)
    final_feedback
  end

  private

  def check_guess(guess)
    count = 0
    while count < 4
      if !@@COLOR_KEY.key?(:"#{guess[count]}") || guess.length != 4
        print "invalid pattern. try again, #{@name}: "
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

  def check_red(guess, pattern)
    temp_array = []
    colors_checked = []
    for i in 0..3
      if guess[i] == pattern[i]
        temp_array.push('red')
        colors_checked.push(guess[i])
      end
    end
    [temp_array, colors_checked]
  end

  def check_white(mod_guess, mod_pattern, red_array)
    fb_final = red_array
    for i in 0...mod_guess.length
      if mod_pattern.include? mod_guess[i]
        temp = mod_pattern.index(mod_guess[i])
        mod_pattern[temp] = ''
        fb_final.push('white')
      end
    end
    fb_final
  end

  def reduce(guess, pattern)
    new_guess = []
    new_pattern = []
    for i in 0...pattern.length
      if guess[i] != pattern[i]
        new_guess.push(guess[i])
        new_pattern.push(pattern[i])
      end
    end
    [new_guess, new_pattern]
  end

  def random_fb(feedback)
    fb_length = feedback.length
    final_fb = []
    for i in 0...fb_length
      temp = rand(0...(fb_length - 0.5 - i)).round
      final_fb.push(feedback[temp])
      feedback.slice!(temp, 1)
    end
    final_fb
  end
end
