# pseudo-code.md

## 1)

### Casual:

```
Given two integers
Add the two integers together
Print that sum
```

### Formal:

```
START

# Given two integers, one called "a" and the other called "b"

SET sum = a + b
PRINT sum

END
```

## 2)

### Casual:

```
Given an array of strings
Initialize an empty string

Iterate through that array, one string at a time:
  - Add the current string to the string we initialized

Print the resulting string
```

```
START

# Given an array of strings called "strings"

SET result = ""
SET iterator = 1

WHILE iterator < length of strings
  SET current = string in strings at space "iterator"
  result = result + current

  iterator = iterator + 1

PRINT result

END
```

## 3)

### Casual:

```
Given an array of integers.
Initialize an empty array

Iterate through each member of the array
  - If the index is odd (or even, depending)
    - Add current number to our new array

Print the resulting array
```

### Formal

```
# Given an array of integers called "ints"

SET result = []
SET iterator = 1

WHILE iterator < length of ints
  SET current = integer in ints at space "iterator"
  IF iterator is odd
    concatinate current to result

  iterator = iterator + 1

PRINT result

END
```
