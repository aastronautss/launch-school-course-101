PLAYER_MARKER = "X".freeze
COMPUTER_MARKER = "O".freeze
BLANK_MARKER = " ".freeze
MAX_WINS = 5

# Standard output
def prompt(input)
  puts "=> #{input}"
end

# Returns a fresh board
def new_board(row_size)
  number_of_spaces = row_size**2
  new_board = {}
  (1..number_of_spaces).each { |num| new_board[num] = BLANK_MARKER }
  new_board
end

# Prints the board
# TODO: refactor for variable sized boards
def display_board(board)
  system 'clear'
  puts ""
  puts " #{board[1]} | #{board[2]} | #{board[3]} "
  puts "---+---+---"
  puts " #{board[4]} | #{board[5]} | #{board[6]} "
  puts "---+---+---"
  puts " #{board[7]} | #{board[8]} | #{board[9]} "
end

def joinor(array, delimiter = ', ', word = 'or')
  array.last = "#{word} array.last" if array.length > 1
  array.join delimiter
end

# Returns an array of space numbers for each empty space in the board.
def empty_spaces(board)
  board.select { |_, marker| marker == BLANK_MARKER }.keys
end

def row_size(board)
  Math.sqrt board.length
end

# Returns all the wining positions on the board
# TODO: Refactor for variable sizes
def winning_positions
  [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # Rows
    [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # Cols
    [[1, 5, 9], [3, 5, 7]]              # Diags
end

# -----------------------
# Board Status
# -----------------------

# Returns true if the board is full.
def full_board?(board)
  empty_spaces(board).empty?
end

# Returns true if the passed space is empty on the passed board.
def space_empty?(space_num, board)
  empty_spaces(board).include? space_num
end

# Inserts the given piece at the given coordinates on the given board.
def play_move(board, space_num, piece)
  board[space_num] = piece
  board
end

# -----------------------
# User input
# -----------------------

# Takes a valid input.
# Returns an array containing the user's sele
def parse_input(raw_input)
  raw_input.to_i
end

# Validates the user's input, making sure it's in the right format.
def valid_input?(raw_input)
  !!raw_input.match(/^\d$/)
end

# -----------------------
# AI
# -----------------------

def threats(board)
  board
end

def any_threats?(board)
  board
end

# -----------------------
# Moves
# -----------------------

# Prompts the user's move, validates it, and places the piece on the board.
def user_move(board)
  prompt "Chose your space: #{joinor(board.keys)}"

  space_num = nil
  loop do
    input = gets.chomp
    if valid_input? input
      space_num = parse_input input
      break if space_empty?(space_num, board)
      prompt "Space not available!"
    else
      prompt "Invalid input!"
    end
  end

  play_move(board, space_num, PLAYER_MARKER)
end

# The computer makes a random move on the board.
def computer_move(board)
  move = empty_spaces(board).sample
  play_move(board, move, COMPUTER_MARKER)
end

# -----------------------
# Win Conditions
# -----------------------

# Returns the PLAYER_MARKER or COMPUTER_MARKER depending on who won, "T" if it's a tie, or nil if
# nobody has won.
def get_result(board)
  positions_to_check = winning_positions

  positions_to_check.each do |line|
    if board.values_at(*line).count(PLAYER_MARKER) ==
       row_size(board)
      return PLAYER_MARKER
    elsif board.values_at(*line).count(COMPUTER_MARKER) ==
          row_size(board)
      return COMPUTER_MARKER
    end
  end

  return "T" if full_board? board
  nil
end

# Takes the result (typically generated by the get_winner method) and score
# hash, and prints a useful message.
def display_score(result, scores)
  case result
  when PLAYER_MARKER
    prompt "Player wins this round!"
  when COMPUTER_MARKER
    prompt "Computer wins this round!"
  when "T"
    prompt "It's a tie!"
  end
  prompt "Player: #{scores[PLAYER_MARKER]}"
  prompt "Computer: #{scores[COMPUTER_MARKER]}"
end

# Increments the winner's score.
def update_scores(result, scores)
  scores[result] += 1 if scores.key? result
end

# Returns true if any score has reached the target.
def game_over?(scores)
  scores.values.any? { |score| score == MAX_WINS }
end

# Prints a winner message. Assumes a winner exists.
def display_winner(scores)
  winner = ''
  if scores[PLAYER_MARKER] == MAX_WINS
    winner = 'Player'
  else
    winner = 'Computer'
  end

  prompt "#{winner} wins!"
end

# Returns true if the user wants to play again (via a prompt) and false
# otherwise.
def user_play_again?
  prompt "Would you like to play again? (y to play again)"
  response = gets.chomp
  response.casecmp('y') == 0
end

# -----------------------
# Main execution loop
# -----------------------

loop do
  scores = { PLAYER_MARKER => 0, COMPUTER_MARKER => 0 }
  loop do
    board = new_board 3
    result = nil

    loop do
      display_board(board)

      board = user_move(board)
      result = get_result(board)
      break if result

      board = computer_move(board)
      result = get_result(board)
      break if result
    end

    update_scores(result, scores)

    display_board(board)
    display_score(result, scores)
    break if game_over?(scores)
  end

  display_winner(scores)

  break unless user_play_again?
end
