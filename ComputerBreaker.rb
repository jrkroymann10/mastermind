require 'pry'

class ComputerBreaker
  @@COLOR_KEY = {
    b: 'blue',
    c: 'cyan',
    g: 'green',
    r: 'light_red',
    m: 'magenta',
    y: 'yellow'
  }
  attr_accessor :guess_pool, :red, :white, :name
  def initialize
    @pool_nums = ['b', 'c', 'g', 'm', 'r', 'y']
    @guess_pool = make_pool
    @red = 0
    @white = 0
    @name = 'cpu'
  end

  def first_pattern
    temp = rand(0..(@guess_pool.length - 1))
    guess = @guess_pool[temp]
    guess = char_to_color(guess)
    guess
  end

  def guess_pattern(guess, feedback = [])
    col_guess = colors_to_char(guess)
    modify_pool(col_guess, feedback)
    first_pattern
  end

  private

  def make_pool
    pool = []
    for i in 0...@pool_nums.length
      for j in 0...@pool_nums.length
        for k in 0...@pool_nums.length
          for l in 0...@pool_nums.length
            temp = [@pool_nums[i], @pool_nums[j], @pool_nums[k], @pool_nums[l]]
              pool.push(temp)
          end
        end
      end
    end
    pool
  end

  def modify_pool(guess, feedback)
    char_fb = translate_feeback(feedback)
    i = 0
    while i < @guess_pool.length
      token = @guess_pool[i]
      if !@guess_pool[i] 
        break
      elsif check_guess(guess, token) != char_fb
        @guess_pool.slice!(i, 1)
        i -= 1
      end
      i += 1
    end
  end

  def check_guess(guess, token)
    red = check_red(guess, token)
    temp = reduce(guess, token)
    white = check_white(temp[0], temp[1])
    [red, white]
  end

  def check_red(guess, token)
    count = 0
    for i in 0...guess.length
      guess[i] == token[i] ? count += 1 : count = count
    end
    count
  end

  def check_white(guess, token)
    count = 0
    for i in 0...guess.length
      pos = token.index(guess[i])
      if pos 
        count += 1
        token[pos] = ''
      end
    end
    count
  end

  def reduce(guess, token)
    new_guess = []
    new_token = []
    for i in 0..3
      if guess[i] != token[i]
        new_guess.push(guess[i])
        new_token.push(token[i])
      end
    end
    [new_guess, new_token]
  end

  def char_to_color(guess)
    colors = []
    for i in 0..3
      colors.push(@@COLOR_KEY[:"#{guess[i]}"])
    end
    colors
  end

  def colors_to_char(guess)
    chars = []
    for i in 0..3
      chars.push(@@COLOR_KEY.key(guess[i]).to_s)
    end
    chars
  end

  def translate_feeback(feedback)
    red = 0
    white = 0
    for i in 0..feedback.length
      if feedback[i] == 'red'
        red += 1
      elsif feedback[i] == 'white'
        white += 1
      end
    end
    [red, white]
  end
end
