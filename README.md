# Cotcube::Indicators

This gem containing the module 'Indicators' is part of the Cotcube suite. Its purpose
is the application on indicators on a given time series. An example should help to
understand how it works:

```ruby
series = 10.times.map {|i| Hash[x: i, y: ((i**2 + 2.0)/(4*i + 1)).round(2)] } 
indicators = { 
  first: Cotcube::Indicators.change(key: :y),
  second: Cotcube::Indicators.change(key: :first, lookback: 2)
}
series.each  {|dataset| indicators.map{|key, lambada| dataset[key] = lambada.call(dataset).round(3) } }
```

This results in the following series (note that the applied function is arbitrary):

| x | y | first | second |
| --- | --- | --- | --- | 
| 0 | 2.0  | 2.0  |  0.0 |
| 1 | 0.6  | -1.4 | -1.4 |
| 2 | 0.67 | 0.07 | -1.93 |
| 3 | 0.85 | 0.18 | 1.58 |
| 4 | 1.06 | 0.21 | 0.14 |
| 5 | 1.29 | 0.23 | 0.05 | 
| 6 | 1.52 | 0.23 | 0.02 |
| 7 | 1.76 | 0.24 | 0.01 | 
| 8 | 2.0  | 0.24 | 0.01 |
| 9 | 2.24 | 0.24 | 0.0  | 

where first displays the change of current `y` to its predecessor and second displays the change of `first` to its pre-predescessor. 

## What is this 'Carrier' thingy

It's just a super tiny helper class. Most indicators rely on a backward aggregation of data. For this purpose the Carrier 
class maintains an array of given length for its indicator, FIFOing out-aged data.

## Currently available indicators

### calc

This indicators is basically a helper. It allows arithmetical combination of 2 parameters (resp. calculation on one by omitting the other). The operation is passed as a block.

### change

Returns the difference (i.e. change) between `carrier.get.last` and `carrier.get.first`, where in most occasions `carrier.size` would be 2--hence comparing a current value with it's predecessor. 

When passed a block, the indicator returns a value only when the block evaluates truthy, otherwise it returns 0'

### index

Returns an index-position of the current value within the carrier (i.e. 1.0 for being the highest, 0.0 for being the lowest value). 

- When passed a block, the indicator returns a value only when the block evaluates truthy, otherwise it returns 0'
- When passed `abs: true`, the absolute value is processed. 
- When passed `reverse: true`, the result will be inverted by `1.0 - result`.

### score

Returns a score position if the current value within the carrier (i.e. 1 for being the highest, __carrier.size__ for being the lowest value). 

- When passed `abs: true`, the absolute value is processed.
- When passed `index: true`, the score is converted to an index, so score 1 matches 1.0 and __carrier.size__ matches 0.0.

### true\_range 

Returns the true range of the current value and it predescessor. Only works when the series contains [:high, :low. :close] or effective alternatives are promoted as parameters. __to get ATR combine this one with sma.__

### sma, ema, rsi

Returns the according classical indicator based on the provided `:key` and `:length`. 


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cotcube-indicators'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cotcube-indicators

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cotcube-indicators.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
