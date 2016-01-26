require 'yaml'

LANGUAGE = 'en'
MESSAGES = YAML.load_file('loan_calc_config.yml')

# Takes a message key and a string indicating the language.
# Returns hash of messages loaded from YAML.
def messages(message, lang='en')
  MESSAGES[lang][message]
end

# Takes a key, prints the appropriate message corresponding to that key.
def prompt(key)
  message = messages(key, LANGUAGE)
  puts "=> #{message}"
end

# Takes a string, returns true if it only contains a number.
def valid_number?(num)
  (integer?(num) || float?(num)) && num.to_f >= 0
end

# Takes a string, returns true if it only contains an integer.
def integer?(num)
  /^\d+$/.match num
end

# Takes a string, returns true if it only contains a float.
def float?(num)
  !(num.to_i.to_s == num) && (/^\d*\.?\d*$/.match num)
end

# ---------------------
# Begin Procedures
# ---------------------

prompt 'welcome'

loop do
  # Input loan amount
  loan_amount = ''
  loop do
    prompt 'loan_amount'
    loan_amount = gets.chomp

    break if valid_number?(loan_amount)

    prompt 'invalid_input'
  end

  loan_amount = loan_amount.to_f

  # Input APR
  apr = ''
  loop do
    prompt 'apr'
    apr = gets.chomp

    break if valid_number?(apr.delete('%'))

    prompt 'invalid_input'
  end

  apr.delete!('%')
  apr = apr.to_f * 0.01

  # Input loan duration
  loan_duration = ''
  loop do
    prompt 'loan_duration'
    loan_duration = gets.chomp

    break if valid_number?(loan_duration)

    prompt 'invalid_input'
  end

  loan_duration = loan_duration.to_f

  # Calculate all the crap needed
  monthly_interest = apr / 12
  duration_in_months = loan_duration * 12

  # Calculate monthly payment
  monthly_payment = (loan_amount * (monthly_interest * ((1 + monthly_interest) ** duration_in_months))) / (((1 + monthly_interest) ** duration_in_months) - 1)

  prompt 'monthly_payment'
  puts '$' + monthly_payment.round(2).to_s

  # Prompt to calculate again
  prompt 'calculate_again'
  calculate_again = gets.chomp
  break unless calculate_again.downcase.start_with? "y"
end
