# ask user for two numbers
# ask user for an operation to perform
# perform operation on the two numbers
# output the result

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_i != 0
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt "Welcome to the calculator! Enter your name:"

name = ''
loop do
  name = gets.chomp

  if name.empty?()
    prompt "Make sure you use a valid name."
  else
    break
  end
end

prompt "Hi #{name}"

loop do # main loop
  num1 = ''
  loop do
    prompt "Enter the first number."
    num1 = gets.chomp

    if valid_number?(num1)
      break
    else
      prompt "Invalid number!"
    end
  end

  num2 = ''
  loop do
    prompt "Enter the second number."
    num2 = gets.chomp

    if valid_number?(num2)
      break
    else
      prompt "Invalid number!"
    end
  end

  operator_prompt = <<-MSG
    Which operation?
    1) Add
    2) Subtract
    3) Multiply
    4) Divide
  MSG
  prompt operator_prompt

  operator = ''
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include? operator
      break
    else
      prompt "You must choose 1, 2, 3, or 4."
    end
  end

  prompt "#{operation_to_message(operator)} the two numbers..."

  ans = case operator
        when "1"
          num1.to_i + num2.to_i
        when "2"
          num1.to_i - num2.to_i
        when "3"
          num1.to_i * num2.to_i
        when "4"
          num1.to_f / num2.to_f
        else
          ans = "I didn't recognize that operator!"
        end

  prompt "Your answer is: #{ans}"

  prompt "Do you want to perform another calculation? (Y to calculate again)"
  answer = gets.chomp
  break unless answer.downcase.start_with? "y"
end

prompt("Goodbye!")
