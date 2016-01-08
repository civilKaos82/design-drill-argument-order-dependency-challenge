# Design Drill: Argument Order Dependency 
 
##Learning Competencies 

* Write code with accurate method definition, arguments, and return values
* Recognize the characteristics of good code and Best Practices, and implement these in code.

##Summary 

Once methods start taking more than one or two parameters, it can be difficult to remember their order.

When a method expects its arguments to arrive in a particular order, it creates a *dependency*. The rest of your code now must *know* about this order, and that makes it brittle. What happens if you want to add or remove a parameter? Now you have to find every place where you call that method and change the argument order accordingly.

A good design solution for this problem is to use **named arguments**. In Ruby, we can implement this design pattern by passing in a hash as a method argument, using the keys of the hash as names for the arguments.

```ruby
def make_a_speech(components = {})
  introduction = components[:introduction]
  inappropriate_anecdote = components[:inappropriate_anecdote]
  long_winded_moralizing = components[:long_winded_moralizing]
  conclusion = components[:conclusion]

  # Now put it all together...
end
```

##Releases

###Release 0 : Use named arguments

Take a look at the `House#initialize` method. My, how many parameters it has!

Refactor the method to use named arguments instead.

**Handling default values**

Some of the parameters defined earlier take default values. Make sure that you incorporate that into your design.

###Release 1 : Be wary of booleans

What happens when you pass a boolean or `nil` value as an argument? Take a look at this example:

```ruby
class Car
  attr_reader :headlights, :gear

  def start_car(options = {})
    @headlights = options[:headlights] || true
    @gear       = options[:gear] || 1
  end
end

herbie = Car.new

# When we start the car, the headlights should be on by default:
herbie.start_car
herbie.headlights # => true

# But what happens when we want to start without headlights?
herbie.start_car(headlights: false)
herbie.headlights # => true  WAT?!
```

The way to get around this is use `Hash#fetch`. Go read [Avdi Grim's post](http://devblog.avdi.org/2009/03/16/go-fetch/). Then refactor your code to use `Hash#fetch` instead of `Hash#[] || <default>` to avoid mishandling of falsey values.
 

<!-- ##Optimize Your Learning  -->

##Resources