class ComputerBreaker
  attr_accessor :guess_pool, :red, :white
  def initialize
    @pool_nums = ['b', 'c', 'g', 'm', 'r', 'y']
    @guess_pool = make_pool
    @red = 0
    @white = 0
    @name = 'cpu'
  end

  def first_pattern
    temp = rand(0..(@guess_pool.length - 1))
    @guess_pool[temp]
  end

  def guess_pattern(guess, feedback)
    modify_pool(guess, feedback)
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
    i = 0
    while i < @guess_pool.length
      p i
      token = @guess_pool[i]
      if !@guess_pool[i] 
        break
      elsif check_guess(guess, token) != feedback
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
end
