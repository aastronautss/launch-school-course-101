# Easy 1

## 1)

```
1
2
2
3
```

## 2)

### 1.
`!=` is a comparative operator, standing for "not equal to." `1 != 2` returns `true`, while `1 != 1` returns false.

### 2.
`!` is a boolean operator, standing for "not." We can put it in front of pretty much any expression and it'll return the opposite boolean value of what that expression would return. `!1` returns `false`, while `!nil` returns true.

### 3.
We typically end a method with a `!` when that method mutates its caller. For example, `Array#reverse!` permanently changes the array that calls that method, thereby affecting all variables that point to it.

Not all destructive variables have that notion: `Array#pop` changes the caller, but has no `!`.

### 4.
We put a `?` before something when we want to define a single character string literal.

Examples:
```ruby
?1 # => "1"
?a # => "a"
?\s # => " "
```

### 5.
We put a `?` at the end of a method when we expect it to return a boolean value.

### 6.
Since every expression returns something in ruby, we use a `!!` to be sure an expression returns a boolean (i.e. we don't want it to be anything but a `true` or a `false`). For example, `!!"a"` returns `true`, while `!!nil` returns `false`.

## 3)

```ruby
advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub!("important", "urgent")
```

### 4)

`Array#delete_at` deletes the entry at the index we pass it, while `Array#delete` goes in and finds the first instance of whatever we pass, and deletes that number. `numbers.delete_at(1)` makes `numbers` be `[1, 3, 4, 5]`, and `numbers.delete(1)` makes `numbers` be `[2, 3, 4, 5]`.

### 5)

```ruby
(10..100).cover? 42
```

### 6)

```ruby
famous_words = "seven years ago..."
"Four score and " + famous_words # => "Four score and seven years ago..."
"Four score and #{famous_words}" # => "Four score and seven years ago..."
"Four score and " << famous_words # => "Four score and seven years ago..."
```

### 7)

```ruby
eval(how_deep) # => 42
```

### 8)

```ruby
flintstones.flatten!
```

### 9)

```ruby
flintsontes.assoc "Barney"
```

### 10)

```ruby
mappings = {}
flintstones.each_with_index do |name, index|
  mappings[name] = index
end
```
