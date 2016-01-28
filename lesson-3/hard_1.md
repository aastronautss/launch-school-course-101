# Hard 1

## 1)

We'd get an error complaining that `greeting` hasn't been initialized. This is because `false` makes the `if` statement skip everything, as there is no `elsif` or `else` clause.

*Oops, this is wrong.*

### Correct answer:

Even though `greeting` never gets initalized, we still get `nil` since Ruby passed over the `if` statement. Weird.

## 2)

```
{:a=>'hi there'}
```
String#<< mutates the caller, so all references to that string return the changes accordingly.

## 3)

### A)
```
one is: one
two is: two
three is: three
```

### B)
```
one is: one
two is: two
three is: three
```

### C)
```
one is: two
two is: three
three is: one
```

## 4)

```ruby
def get_uuid
  digits = ('0'..'9').to_a + ('a'..'f').to_a
  section_sizes = [8, 4, 4, 4, 12]

  uuid = ""
  section_sizes.each_with_index do |size, index|
    size.times do
      uuid << digits.sample
    end

    uuid << "-" unless index >= section_sizes.length - 1
  end

  uuid
end
```

## 5)

If we didn't want to use regex, we could add use `return false` instead of `break` on line 5, and add the following line after line 2:

```ruby
return false unless dot_separated_words.length == 4
```

We can take out the word `return` on line 7.
