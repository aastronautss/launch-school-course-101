def prompt(message)
  puts "=> #{message}"
end

CHOICES = ['rock', 'paper', 'scissors']

loop do
  # User choice
  choice = ''
  loop do
    prompt "Choose one: #{CHOICES.join(", ")}"
    choice = gets.chomp

    break if CHOICES.include? choice.downcase

    prompt 'That\'s not a valid choice.'
  end

  # Computer choice
  computer_choice = CHOICES.sample

  prompt "You chose #{choice}; the computer chose #{computer_choice}"

  if (choice == 'rock'     && computer_choice == 'scissors') ||
     (choice == 'paper'    && computer_choice == 'rock')     ||
     (choice == 'scissors' && computer_choice == 'paper')
    prompt 'You win!'
  elsif (choice == 'rock'     && computer_choice == 'paper')    ||
        (choice == 'paper'    && computer_choice == 'scissors') ||
        (choice == 'scissors' && computer_choice == 'rock')
    prompt 'The computer wins!'
  end

  prompt 'Do you want to play again?'
  play_again = gets.chomp
  break unless play_again.casecmp('y') == 0
end
