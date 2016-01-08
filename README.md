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


### Default Argument Values
```ruby
# With individual parameters ...
def tip(bill, tip_percentage = 0.18)
  bill * tip_percentage
end

# With named arguments as a hash ...
def tip(args)
  tip_percentage = args[:tip_percentage] || 0.18
  
  args[:bill] * tip_percentage
end
```
*Figure 2*.  Setting default values when a method accepts individual arguments and named arguments.

When we define a method with individual parameters, it's fairly straightforward to provide default values (see Figure 2).  When our methods accept a hash, we need to check the keys in the hash.  If the key exists, use its value; otherwise, use this value (See Figure 2).  Unfortunately, checking for keys in this way can cause issues when the value of the key is falsey:  `nil` or `false`.  We get around this by using `Hash#fetch`.  Read [Avdi Grim's post](http://devblog.avdi.org/2009/03/16/go-fetch/) on how to use `#fetch` to avoid mishandling falsey values.


##Releases

###Release 0 : Use named arguments

Take a look at the `House#initialize` method. My, how many parameters it has!

Refactor the method to use named arguments instead.

 

<!-- ##Optimize Your Learning  -->

##Resources

[Practical Object-Oriented Design in Ruby]: http://www.poodr.com/
