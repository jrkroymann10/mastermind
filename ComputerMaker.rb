require 'pry'

# Computer CodeMaker
class ComputerMaker
  @@COLORS = ['black', 'cyan', 'magenta', 'yellow', 'green', 'light_red', 'blue']
  @@FB_COLORS = ['red', 'white', 'black']
  def initialize; end

  def select_pattern
    color_array = []
    for i in 0..3
      temp = (rand() * 6.499).round
      color_array.push(@@COLORS[temp])
    end
    color_array
  end

  def give_feedback(guess, pattern) # Hopefully arrays of strings of colors
    temp_array = check_red(guess, pattern)
    mod_guess = reduce_guess(temp_array[1], guess)
    temp_fb = check_white(mod_guess, pattern, temp_array[0])
  end

  def check_red(guess, pattern)
    temp_array = []
    colors_checked = []
    for i in 0...guess.length
      if (pattern.include? guess[i]) && (pattern.index(guess[i]) == i)
        temp_array.push('red')
        colors_checked.push(guess[i])
        binding.pry
      end
    end
    [temp_array, colors_checked]
  end

  def check_white(mod_guess, pattern, red_array)
    fb_final = red_array
    for i in 0...mod_guess.length
      if pattern.include? mod_guess[i]
        temp = pattern.index(mod_guess[i])
        pattern[temp] = ''
        fb_final.push('white')
      end
    end
    fb_final
  end

  def reduce_guess(colors_checked, pattern)
    new_pattern = []
    for i in 0...pattern.length
      if !colors_checked.include? pattern[i]
        new_pattern.push(pattern[i])
      end
    end
    new_pattern
  end
end


cpu = ComputerMaker.new

puts cpu.give_feedback(['cyan', 'cyan', 'cyan', 'magenta'], ['cyan', 'cyan', 'magenta', 'magenta'])

# class String
#   def black; "\e[30m#{self}\e[0m" end
#   def red; "\e[31m#{self}\e[0m" end
#   def green; "\e[32m#{self}\e[0m" end
#   def brown; "\e[33m#{self}\e[0m" end
#   def blue; "\e[34m#{self}\e[0m" end
#   def magenta; "\e[35m#{self}\e[0m" end
#   def cyan; "\e[36m#{self}\e[0m" end
#   def gray; "\e[37m#{self}\e[0m" end
 
#   def bg_black; "\e[40m#{self}\e[0m" end
#   def bg_red; "\e[41m#{self}\e[0m" end
#   def bg_green; "\e[42m#{self}\e[0m" end
#   def bg_brown; "\e[43m#{self}\e[0m" end
#   def bg_blue; "\e[44m#{self}\e[0m" end
#   def bg_magenta; "\e[45m#{self}\e[0m" end
#   def bg_cyan; "\e[46m#{self}\e[0m" end
#   def bg_gray; "\e[47m#{self}\e[0m" end
 
#   def bold; "\e[1m#{self}\e[22m" end
#   def italic; "\e[3m#{self}\e[23m" end
#   def underline; "\e[4m#{self}\e[24m" end
#   def blink; "\e[5m#{self}\e[25m" end
#   def reverse_color; "\e[7m#{self}\e[27m" end
# end
