# ask user for two numbers
# ask user for an operation to perform
# perform operation on the two numbers
# output the result

require 'yaml'

# Standardized output.
def prompt(message)
  puts "=> #{message}"
end

# Takes a string, returns true if it contains only a number.
def number?(num)
  integer?(num) || float?(num)
end

# Takes a string, returns true if it contains only an integer.
def integer?(num)
  /^\d+$/.match num
end

# Takes a string, returns true if it contains only a float.
def float?(num)
  !(num.to_i.to_s == num) && (/^\d*\.?\d*$/.match num)
end

# Helpful message for calculation process.
def operation_to_message(op)
  word = case op
         when '1'
           'Adding'
         when '2'
           'Subtracting'
         when '3'
           'Multiplying'
         when '4'
           'Dividing'
         end
  word
end

# Takes two strings, returns true if either is a float.
def any_floats?(num1, num2)
  float?(num1) || float?(num2)
end

# -------------------------
# Begin procedures
# -------------------------

config = YAML.load_file('calc_config.yml') # Load config file

# Language selection procedure

lang = ''
prompt config['lang_select']

loop do
  lang = gets.chomp

  break if %w(en hu).include? lang
  prompt config['invalid_selection']
end

prompts = config[lang]

prompt prompts['welcome']

name = ''
loop do
  name = gets.chomp

  break unless name.empty?
  prompt prompts['valid_name']
end

prompt "Hi #{name}"

loop do # main loop
  num1 = ''
  loop do
    prompt prompts['first_number']
    num1 = gets.chomp

    break if number?(num1)

    prompt prmopts['invalid_number']
  end

  num2 = ''
  loop do
    prompt prompts['second_number']
    num2 = gets.chomp

    break if number?(num2)

    prompt prompts['invalid_number']
  end

  prompt prompts['operator']

  operator = ''
  loop do
    operator = gets.chomp

    break if %w(1 2 3 4).include? operator
    prompt "You must choose 1, 2, 3, or 4."
  end

  prompt operation_to_message(operator) + prompts['calculating']

  ans = case operator
        when "1"
          if any_floats?(num1, num2)
            num1.to_f + num2.to_f
          else
            num1.to_i + num2.to_i
          end
        when "2"
          if any_floats?(num1, num2)
            num1.to_f + num2.to_f
          else
            num1.to_i - num2.to_i
          end
        when "3"
          if any_floats?(num1, num2)
            num1.to_f + num2.to_f
          else
            num1.to_i * num2.to_i
          end
        when "4"
          num1.to_f / num2.to_f
        end

  prompt prompts['answer'] + ans.to_s

  prompt prompts['calculate_again']
  answer = gets.chomp
  break unless answer.downcase.start_with? "y"
end

prompt prompts['goodbye']
