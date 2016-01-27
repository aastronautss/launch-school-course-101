CHOICES_MAP = { 'r'  => 'rock',
                'p'  => 'paper',
                's'  => 'scissors',
                'l'  => 'lizard',
                'sp' => 'spock' }.freeze
CHOICES = CHOICES_MAP.values.freeze
DISPLAY_CHOICES = CHOICES_MAP.map do |short, long|
                    "#{long} (#{short})"
end.join(', ').freeze
RESULT_MAP = { player: "Player wins this round!",
               computer: "Computer wins this round!",
               tie: "It's a tie!" }.freeze
MAX_WINS = 5

$player_points = 0
$computer_points = 0 # I understand global variables are typically a no-no, but
                     # I would ideally wrap this entire program into a class,
                     # in which these would be instance variables.

# Standard message output
def prompt(message)
  puts "=> #{message}"
end

# Takes the user's input and returns the matching string if it maps to our
# CHOICES_MAP.
def parse_input(input)
  CHOICES_MAP[input] || input
end

# Takes two player choices. Returns true if the first player wins.
def win?(first, second)
  case first
  when 'rock'
    second == 'scissors' || second == 'lizard'
  when 'paper'
    second == 'rock'     || second == 'spock'
  when 'scissors'
    second == 'paper'    || second == 'lizard'
  when 'lizard'
    second == 'spock'    || second == 'paper'
  when 'spock'
    second == 'rock'     || second == 'scissors'
  end
end

# Takes the player and the computer choices.
# Returns the symbol for the winner (player, computer, tie)
def get_result(player, computer)
  if win?(player, computer)
    :player
  elsif win?(computer, player)
    :computer
  else
    :tie
  end
end

# Updates the score based on the symbol passed to the method
def update_score(result)
  case result
  when :player
    $player_points += 1
  when :computer
    $computer_points += 1
  end
end

# Prints the score
def display_score
  prompt "Player: #{$player_points}"
  prompt "Computer: #{$computer_points}"
end

# Returns the symbol corresponding to the winner.
def winner
  return :player if $player_points == MAX_WINS
  return :computer if $computer_points == MAX_WINS
  nil
end

# -------------------
# Begin procedures
# -------------------

loop do
  $player_points = 0
  $computer_points = 0

  until winner
    display_score

    # User choice
    choice = ''
    loop do
      prompt "Choose one: #{DISPLAY_CHOICES}"
      choice = parse_input(gets.chomp.downcase)

      break if CHOICES.include? choice

      prompt "That's not a valid choice."
    end

    # Computer choice
    computer_choice = CHOICES.sample

    prompt "Player chose #{choice}; the computer chose #{computer_choice}."

    result = get_result(choice, computer_choice)
    prompt RESULT_MAP[result]
    update_score(result)
  end

  prompt "#{winner.to_s.capitalize} wins!"

  prompt 'Do you want to play again?'
  play_again = gets.chomp
  break unless play_again.casecmp('y') == 0
end

prompt "Thanks for playing! Good bye!"
