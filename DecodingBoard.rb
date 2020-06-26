require 'colorize'

# Board Display
class DecodingBoard
  def initialize
    @display = [[''], ['| Guesses | Feedback |'], ['----------------------']]
    for i in 0..23
      i.even? ? @display += ['|         |          |'] : @display += ['----------------------']
    end
    @display += ['|                    |'] + ['----------------------']
  end

  def set_pattern(color_array)
    pos = 7
    turn = 27
    for i in 0...color_array.length()
      temp= build_color_block(color_array[i])
      @display[turn][pos] = temp
      pos += 16
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

  def full_view
    puts @display
  end

  def hidden_view
    puts @display[0..26]
  end
end





