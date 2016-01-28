# Medium 3

## 1)

`a_outer` and `d_outer` will have the same ID, while `b_outer` and `c_outer` will have different IDs. The block won't change anything, but re-assigning the variables will. If they change back, I think Ruby hasn't performed any garbage collection or something, since the IDs switched back to what they were before.

## 2)

The IDs of our variables remain the same after the method call, even though the method messes with the variables.

## 3)

The string will be unchanged, while the array will have a new value added to it after being passed to the method. String#+= creates a new object and changes the pointer to that object, while Array#<< modifies the existing object, and so all pointers to that object will return values that reflect that change.

## 4)

The string will change, while the array doesn't change even after the method call. This is because String#gsub! modifies the object to which the pointer points, thus being reflected to all pointers pointing to that object. For the array, we just reassign the pointer to a new object, and so the original object (and all pointers pointing to it) remains unchanged.

## 5)

```ruby
def color_valid(color)
  color == 'blue' || color == 'green'
end
