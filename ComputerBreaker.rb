

class ComputerBreaker
  @@COLOR_KEY = {
    b: 'blue',
    c: 'cyan',
    g: 'green',
    r: 'light_red',
    m: 'magenta',
    y: 'yellow'
  }

  attr_reader :initial_pattern
  attr_accessor :feedback, :final_guess, :guesses, :colors

  def initialize
    @colors = ['blue', 'cyan', 'green', 'light_red', 'magenta', 'yellow']
    @initial_pattern = random_guess
    @feedback = []
    @guesses = [@initial_pattern, ]
    @final_guess = []
  end

  def random_guess
    color_array = []
    for i in 0..3
      temp = (rand(0...(@colors.length - 0.5))).round
      color_array.push(@colors[temp])
    end
    color_array
  end

  def new_guess(feedback, turn)
    hash_fb = fb_hash(feedback)
    case_selection(fb_hash, feedback, turn)
  end

  def fb_hash(feedback = [])
    count = Hash.new(0)
    feedback.each { |fb| count[fb] += 1 }
    count
  end

  def case_selection(fb_hash, feedback, turn)
    case
      when fb_hash.empty? then case_one
      when fb_hash[red] == 1 then
      when fb_hash[white] == 1 then
      when fb_hash[red] == 2 then
      when fb_hash[white] == 2 then
      when fb_hash[red] == 3 then
      when fb_hash[white] == 3 then
      when fb_hash[white] == 4 then
      when fb_hash[red] == 1 && fb_hash[white] == 1 then
      when fb_hash[red] == 1 && fb_hash[white] == 2 then
      when fb_hash[red] == 1 && fb_hash[white] == 3 then
      when fb_hash[red] == 2 && fb_hash[white] == 1 then
      when fb_hash[red] == 2 && fb_hash[white] == 2 then
      when fb_hash[red] == 3 && fb_hash[white] == 1 then
    end
  end

  def case_one(turn)
    remove_colors(@guesses[turn -1])
    random_guess
  end

  def case_two(turn)

  end

  def remove_colors(guess) # guess = array of colors 
    for i in 0..3
      if @colors.include? guess[i]
        temp = @colors.index(guess[i])
        @colors.slice!(temp, 1)
      end
    end
  end


end

x = ComputerBreaker.new
p x.colors
p x.initial_pattern
p x.new_guess([], 1)
p x.colors
