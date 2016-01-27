# Medium 2

## 1)

```ruby
sum = 0
munsters.values.each do |data|
  sum += data['age'] if data['gender'] == 'male'
end
```

## 2)

```ruby
munsters.each do |name, data|
  puts "#{name} is a #{data['age']} year old #{data['gender']}."
end
```
## 3)

```ruby
def tricky_method(a_string_param, an_array_param)
    a_string_param += "rutabaga"
    an_array_param += "rutabaga"

    [a_string_param, an_array_param]
end

my_string = "pumpkins"
my_array = ["pumpkins"]

new_string, new_array = tricky_method(my_string, my_array)
puts "My string looks like this now: #{new_string}"
puts "My array looks like this now: #{my_array}"
```

The change now uses instance methods which don't mutate the caller.

## 4)

```ruby
sentence = "Humpty Dumpty sat on a wall."
sentence.split(/\W/).reverse.join(' ')
```

## 5)

```
34
```

## 6)

The family's data will change, since what gets passed is a pointer to the hash, not a copy of the hash.

## 7)

```
"Paper"
```

## 8)

```
"No"
```
