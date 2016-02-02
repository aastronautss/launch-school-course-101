CARD_NAMES = { 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6",
               7 => "7", 8 => "8", 9 => "9", 10 => "10",
               11 => "Jack", 12 => "Queen", 13 => "King", 14 => "Ace" }
SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
VALUES = (2..14).to_a

# Standard output
def prompt(message)
  puts "=> #{message}"
end

# Standard list of elements.
def joinor(array, delimiter = ', ', word = 'or')
  array[-1] = "#{word} #{array[-1]}" if array.length > 1
  array.join delimiter
end

# Returns a deck of card "objects" in the form of an array of hashes.
def initialize_deck
  deck = []

  VALUES.each do |value|
    SUITS.each do |suit|
      deck << { value: value, suit: suit }
    end
  end

  deck.shuffle
end

# Pops two cars off the top of the given deck and returns those two cards.
def deal!(deck)
  hand = []
  hand << deck.pop
  hand << deck.pop
  hand
end

# If the card is above 11 (i.e. a face card), returns 10.
def evaluate_non_ace_card(card_value)
  card_value < 11 ? card_value : 10
end

# Used to evaluate an Ace card based on the given sum
# (Avoids busting if possible)
def one_or_eleven(sum)
  sum + 11 > 21 ? 1 : 11
end

# Takes a hand and counts up its value. Avoids busting if possible.
def evaluate_hand(hand)
  aces = hand.select { |card| card[:value] == 14 } # First take out aces
  hand_minus_aces = hand - aces

  sum = hand_minus_aces.inject(0) do |sum, card| # Sum up non-ace cards
    sum += evaluate_non_ace_card card[:value]
  end

  aces.each do |_| # Add aces
    sum += one_or_eleven(sum)
  end

  sum
end

# Returns true if the given hand's value is over 21.
def bust?(hand)
  evaluate_hand(hand) > 21
end

# Returns the winning hand (defaults to dealer in the case of a tie)
def get_winner(player_hand, dealer_hand)
  evaluate_hand(player_hand) > evaluate_hand(dealer_hand) ? 'player' : 'dealer'
end

# Pops a card from the deck and places it in the hand.
def hit!(deck, hand)
  hand << deck.pop
end

# Returns a string giving the name of the card.
def name_of_card(card)
  "#{CARD_NAMES[card[:value]]} of #{card[:suit]}"
end

# Returns a string listing (in english) the names of each card in the
# given hand.
def list_cards(hand)
  list = hand.map do |card|
    name_of_card(card)
  end

  joinor(list, ', ', 'and')
end

# Displays the cards in play in a readable format. Meant for the player's
# turn.
def show_hands_player_turn(player_hand, dealer_hand)
  prompt "Dealer has: #{name_of_card(dealer_hand.first)} and unknown card."
  prompt "Player has: #{list_cards(player_hand)}"
end

# Reveals the dealer's full hand.
def dealer_reveal(hand)
  prompt "Dealer has: #{list_cards(hand)}"
end

# Input validation.
def valid_input?(input)
  input == 's' || input == 'h'
end

# User input validation loop.
def user_input
  input = ''
    loop do # Input validation
      prompt "Hit (h) or stay (s)?"
      input = gets.chomp.downcase
      break if valid_input?(input)
    end

    input
end

# Player's turn. Returns 'dealer' if the player busts.
def player_turn!(deck, player_hand, dealer_hand)
  loop do
    show_hands_player_turn(player_hand, dealer_hand)

    input = user_input

    case input
    when 'h'
      hit!(deck, player_hand)
      prompt "You are dealt a #{name_of_card(player_hand[-1])}."
      if bust?(player_hand)
        prompt "Player busts!"
        return 'dealer'
      end
    when 's'
      break
    end
  end
end

# Dealer's turn. Returns 'player' if the dealer busts.
def dealer_turn!(deck, hand)
  dealer_reveal(hand)

  while evaluate_hand(hand) < 17
    hit!(deck, hand)
    prompt "Dealer hits and draws a #{name_of_card(hand[-1])}."

    if bust?(hand)
      prompt "Dealer busts!"
      return 'player'
    end
  end
end

# Prints a readable format for the winner.
def display_winner(winner)
  prompt "#{winner.capitalize} wins!"
end

# Returns true if the user wants to play again (via a prompt) and false
# otherwise.
def user_play_again?
  prompt "Would you like to play again? (y to play again)"
  response = gets.chomp
  response.casecmp('y') == 0
end

# --------------------------
# Main execution loop
# --------------------------

loop do
  deck = initialize_deck
  player_hand = deal!(deck)
  dealer_hand = deal!(deck)
  winner = nil

  winner = player_turn!(deck, player_hand, dealer_hand)
  winner = dealer_turn!(deck, dealer_hand) unless winner

  winner = get_winner(player_hand, dealer_hand) unless winner

  display_winner(winner)

  break unless user_play_again?
end
