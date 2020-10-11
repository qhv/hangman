class Game
  TOTAL_ERRORS_ALLOWED = 7

  def initialize(word)
    @letters = word.chars
    @normalized_letters = @letters.map(&method(:normalize_letter))

    @user_guesses = []
  end

  def errors
    return @user_guesses - @normalized_letters
  end

  def errors_made
    return errors.length
  end

  def errors_allowed
    return TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    result =
      @letters.map do |letter|
        if @user_guesses.include?(normalize_letter(letter))
          letter
        else
          nil
        end
      end

    return result
  end

  def lost?
    return errors_allowed == 0
  end

  def normalize_letter(letter)
    return "Е" if letter == "Ё"
    return "И" if letter == "Й"
    letter
  end

  def over?
    return won? || lost?
  end

  def play!(letter)
    normalized_letter = normalize_letter(letter)

    if !over? && !@user_guesses.include?(normalized_letter)
      @user_guesses << normalized_letter
    end
  end

  def won?
    return (@normalized_letters - @user_guesses).empty?
  end

  def word
    return @letters.join
  end
end
