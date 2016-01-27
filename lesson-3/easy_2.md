# Easy 2

## 1)

```ruby
!ages["Spot"].nil?
```

### Bonus
```ruby
ages.has_key? "Spot"
# or:
ages.include? "Spot"
```

## 2)

```ruby
ages.values.inject(0) do { |sum, age| sum + age }
# or:
ages.values.inject(:+)
```

## 3)

```ruby
ages.delete_if { |_, age| age > 100 }
```

## 4)

```ruby
munsters_description.capitalize
munsters_destription.swapcase
munsters_description.downcase
munsters_description.upcase
```

## 5)

```ruby
additional_ages.each { |name, age| ages[name] = age }
# or:
ages.merge!(additional_ages)
```

## 6)

```ruby
ages.values.min
```

## 7)

```ruby
advice.match('Dino')
```

## 8)

```ruby
flintstones.find_index { |name| name.match /^Be/ }
```

### 9)

```ruby
flintstones.map! { |name| name[0..2] }
```

### 10)

```ruby
# see above
```
