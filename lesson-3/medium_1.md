# Medium 1

## 1)

```ruby
10.times do { |num| puts (" " * num) + "The Flintstones Rock!" }
```

## 2)

```ruby
statement = "The Flintstones Rock"
letters = statement.gsub(/\W+/, '')
char_frequency = {}
letters.each_char do |letter|
  if char_frequency[letter]
    char_frequency[letter] += 1
  else
    char_frequency[letter] = 1
  end
end
```

## 3)

We get a TypeError here because a string's "+" operator can only take another string; there is no functionality in that method to call a to_s method of what we pass to it. We would need to call Integer#to_s on (40 + 2) or interpolate it.

```ruby
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{40+2}"
```

## 4)

The first snippet would skip every other member of that array, since Array#each goes by index. The output would be:

```
1
3
```

and return `[3, 4]` because we've shifted the first two members off of the array. We get this output because the first iteration it the block is passed the member at index 0, which in this case is `1`. Array#shift is called, so the member at index 0 is removed, shifting the indices of each remain member down one.

The second iteration passes to the block the member at index 1, which is now 3. This is printed, and the member at index 0 is removed, and all indices are shifted. There is no longer a member at index 2, so the loop finishes.

The second snippet would output:

```
1
2
```

and return `[1, 2]`.

## 5)

We can just change the loop:

```ruby
while dividend > 0 do
  # ...
end
```

This way, we just return an empty array if the number is less than 1.

### Bonus 1.

a % b is 0 if b divides a.

### Bonus 2.

This line makes sure our array is returned. We don't need to explicitly say `return` since a method always just returns the last expression it executed.

## 6)

In the first implementation, the original array is modified (in this case called `buffer`), while the original array in the second implementation (called `input_array`) stays the same, as Array#+ isn't destructive.

## 7)

Since a method has its own scope, it is unaware of all variables declared outside of its declaration, save for global variables (which Rubocop yelled at me for using once). I would add a third parameter to fib (e.g. `def fib(first_num, second_num, limit)`).

## 8)

```ruby
def titleize(title)
  boring_words = %w(a an and as at but by for from in into is nor of off on onto or out so the to up via upon with vs. vs)

  words = title.split " "

  words.first.capitalize!
  words.each do |word|
    word.capitalize! unless boring_words.include? word
  end

  words.join " "
end

titleize "tyler is a person" # => "Tyler is a Person"
```

## 9)

```ruby
munsters.each do |name, info|
  case info['age']
  when 0..17
    info['age_group'] = 'kid'
  when 18..64
    info['age_group'] = 'adult'
  else
    info['age_group'] = 'senior'
  end
end
```

