require "byebug"
class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman::random_word
    @guess_word = Array.new(@secret_word.length,"_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end
  
  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    return true if attempted_chars.include?(char)
    false
  end

  def get_matching_indices(char)
    result = []
    @secret_word.each_char.with_index do |a, i|
      result << i if a == char
    end
    result
  end

  def fill_indices(char, arr)
    arr.each {|i| @guess_word[i] = char}
  end

  def try_guess(char)
    if already_attempted?(char)
      p "that has already been attempted"
      return false
    else
      arr = get_matching_indices(char)
      @attempted_chars << char
      if arr.empty?
        @remaining_incorrect_guesses -= 1
      else
        fill_indices(char,arr )
      end
    end
    true
  end

  def ask_user_for_guess
    p "Enter a char:"
    char = gets.chomp
    try_guess(char)
  end

  def win?
    if @guess_word.join == @secret_word
      p "WIN"
      return true 
    end
    false
  end
  
  def lose?
    if @remaining_incorrect_guesses == 0
      p "LOSE"
      return true 
    end
    false
  end

  def game_over?
    if self.win? || self.lose?    
      p @secret_word 
      return true
    end
    false
  end
end
