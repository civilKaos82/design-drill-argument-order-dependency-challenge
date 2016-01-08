# Design Drill: Argument Order Dependency 
 
## Summary
In [Practical Object-Oriented Design in Ruby][] (POODR),  Sandi Metz encourages designing applications that are easy to change.  We're going to look at one strategy for making our applications less brittle and costly to change:  removing argument order dependencies from our methods.

When a method accepts arguments, it creates a *dependency*: any part of our code that calls the method must know which arguments to pass and in which order to pass them.  This isn't too problematic when the method only accepts one or two arguments, but beyond this, it could be difficult to remember their order.

And what happens if we decide to add a parameter to our method or to remove one?  What if we want to change the order in which arguments should be passed.  Well, we'd have to find every place where we call the method and change the arguments accordingly.

A good design solution for this problem is to use *named arguments*. In Ruby, one way to implement this design pattern is for our our methods to expect a hash rather than individual arguments.  The individual arguments become expected keys in the hash.  See Figure 1 for an example.

```ruby
# From ...
Album.new('Kidz Bop 31', 'Kidz Bop Kids', 'January 15, 2016', 'Kidz Bop', '51:12', 'B018TFEU4O')


# To ...
album_details = {
  :title        => 'Kidz Bop 31',
  :artist       => 'Kidz Bop Kids',
  :release_date => 'January 15, 2016',
  :label        => 'Kidz Bop',
  :run_time     => '51:12'
  :asin         => 'B018TFEU4O'
}

Album.new(album_details)
```
*Figure 1*.  Moving from multiple arguments to one hash.


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

[Practical Object-Oriented Design in Ruby]: http://www.poodr.com/
