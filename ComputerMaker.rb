

# Computer CodeMaker
class ComputerMaker
  @@COLORS = ['cyan', 'magenta', 'yellow', 'green', 'light_red', 'blue']
  @@FB_COLORS = ['red', 'white']
  attr_reader :pattern
  attr_accessor :feedback
  def initialize
    @pattern = select_pattern
    @feedback = []
  end

  def select_pattern
    color_array = []
    for i in 0..3
      temp = (rand() * 5.499).round
      color_array.push(@@COLORS[temp])
    end
    color_array
  end

  def give_feedback(guess, pattern)
    temp_array = check_red(guess, pattern)
    reduced = reduce(guess, pattern)
    temp_fb = check_white(reduced[0], reduced[1] , temp_array[0])
    final_feedback = random_fb(temp_fb)
    final_feedback
  end

  private

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
        # binding.pry
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