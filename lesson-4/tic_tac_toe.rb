STANDARD_BOARD = [[" ", " ", " "],
                  [" ", " ", " "],
                  [" ", " ", " "]].freeze


# Standard output
def prompt(input)
  puts "=> #{input}"
end

# Returns a fresh board
def set_board
  STANDARD_BOARD.clone
end

# Prints the board
def display_board(board)
  puts '  1   2   3'
  horiz_seprator = '  --+---+--'
  board.each_with_index do |row, row_index|
    puts "#{row_index + 1} #{row[0]} | #{row[1]} | #{row[2]}"
    puts horiz_seprator unless row_index >= board.length - 1
  end
end

# Returns an array of coordinates for each empty space in the board.
# Each coordinate is in the form of an array [x, y].
def empty_spaces(board)
  empties = []
  board.each_with_index do |row, row_index|
    row.each_with_index do |col, col_index|
      empties << [row_index, col_index] if col == ' '
    end
  end
  empties
end

def get_cols(board)
  cols = Array.new(board[0].size) { Array.new }
  board.each do |row|
    row.each_with_index do |cell, col_index|
      cols[col_index] << cell
    end
  end

  cols
end

def get_rows(board)
  board
end

def get_diags(board)
  diags = Array.new(2) { Array.new }

  0.upto(2)   { |index| diags[0] << board[index][index] }
  diags[1] << board[0][2]
  diags[1] << board[1][1]
  diags[1] << board[2][0]

  diags
end

def full_board?(board)
  empty_spaces(board).empty?
end

# Inserts the given piece at the given coordinates on the given board.
def play_move(board, coords, piece)
  x, y = coords
  board[x][y] = piece
  board
end

def parse_input(raw_input)
  raw_input.gsub!(/(\?|\s)/, '')
  coords = raw_input.split ''
  coords.map! { |number| number.to_i - 1 }
  coords
end

def valid_input?(raw_input)
  raw_input.match(/^\d,?\s?\d$/)
end

def space_empty?(coords, board)
  empty_spaces(board).include? coords
end

def user_move(board)
  prompt 'Pick your coordinates (row, column): '
  prompt 'Format: 2, 3 or 1 3 or 21'

  coords = []
  loop do
    input = gets.chomp
    if valid_input? input
      coords = parse_input input
      break if space_empty?(coords, board)
      prompt "Space not available!"
    else
      prompt "Invalid input!"
    end
  end

  play_move(board, coords, 'X')
end

def computer_move(board)
  available_spaces = empty_spaces board
  move = empty_spaces(board).sample
  play_move(board, move, "O")
end

def get_winner(board)
  positions_to_check = get_rows(board) + get_cols(board) + get_diags(board)
  full_rows = positions_to_check.select do |position|
    position.all? { |piece| piece == "X" } ||
    position.all? { |piece| piece == "O" }

  end

  return full_rows[0][0] unless full_rows.empty?
  return "T" if full_board? board

  nil
end

def display_result(result)
  case result
  when "X"
    prompt "Player wins!"
  when "O"
    prompt "Computer wins!"
  when "T"
    prompt "It's a tie!"
  end
end

def user_play_again?

end

# -----------------------
# Main execution loop
# -----------------------

loop do
  board = set_board
  result = nil

  loop do
    display_board(board)

    board = user_move(board)
    board = computer_move(board)

    result = get_winner(board)
    break if result
  end

  display_board(board)
  display_result(result)
  break unless user_play_again?
end
