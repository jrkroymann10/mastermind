require 'colorize'
require 'pry'

# Board Display
class DecodingBoard
  def initialize
    @display = [[''], ['| Guesses | Feedback |'], ['----------------------']]
    for i in 0..24
      i.even? ? @display += ['|         |          |'] : @display += ['----------------------']
    end
  end

  def update_guess(turn, color_array)
    pos = 2
    turn = (turn * 2) + 1
    for i in 0...color_array.length
      temp = build_color_block(color_array[i])
      @display[turn][pos] = temp
      pos += 16
    end
  end

  def update_feedback(turn, color_array)
    pos = 68
    turn = (turn * 2) + 1
    for i in 0...color_array.length
      temp = build_color_block(color_array[i])
      @display[turn][pos] = temp
      pos += 16
    end
  end

  def build_color_block(color)
    ' '.colorize(background: :"#{color}")
  end

  def view_board
    puts @display
  end
end

x = DecodingBoard.new
x.view_board
x.update_guess(1, ['cyan', 'blue', 'magenta', 'yellow'])
x.view_board
x.update_feedback(1, ['red', 'white', 'red'])
x.view_board
x.update_guess(2, ['cyan', 'blue', 'magenta', 'yellow'])
x.update_feedback(2, ['white', 'white', 'red'])
x.view_board


# Colorize Colors
# black
# light_black
# red
# light_red
# green
# light_green
# yellow
# light_yellow
# blue
# light_blue
# magenta
# light_magenta
# cyan
# light_cyan
# white
# light_white




