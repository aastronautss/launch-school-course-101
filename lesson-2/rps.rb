def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  (first   == 'rock'     && second == 'scissors') ||
    (first == 'paper'    && second == 'rock')     ||
    (first == 'scissors' && second == 'paper')
end

def display_result(player, computer)
  if win?(player, computer)
    prompt 'You win!'
  elsif win?(computer, player)
    prompt 'The computer wins!'
  else
    prompt 'It\'s a tie!'
  end
end

CHOICES = %w(rock paper scissors).freeze

loop do
  # User choice
  choice = ''
  loop do
    prompt "Choose one: #{CHOICES.join(', ')}"
    choice = gets.chomp

    break if CHOICES.include? choice.downcase

    prompt 'That\'s not a valid choice.'
  end

  # Computer choice
  computer_choice = CHOICES.sample

  prompt "You chose #{choice}; the computer chose #{computer_choice}"

  display_result(choice, computer_choice)

  prompt 'Do you want to play again?'
  play_again = gets.chomp
  break unless play_again.casecmp('y') == 0
end

prompt "Thanks for playing! Good bye!"
