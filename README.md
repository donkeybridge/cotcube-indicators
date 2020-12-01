# Tritangent

This gem provides a class (and will maybe later provide a commandline tool) to process 
time series data to find multitangential slopes (N-tangents), with a minimum of 3 
shared points (hence tri-tangents). 

the idea is actually based on the bitangents gem, but tries to improve data quality be
testing, whether this way less data is found. 

The underlying algorithm can run either for upper slopes or lower slopes:

1. Given it runs for upper slopes, first tries to find the relative high
   by running a binary search between 90 and -90 starting with an angle of 0.
   The graph is sheared until no points are left above the sheared graph. 
   To speed up processing, lower scans of the binary search cause a datpoints 
   fade away from the dataset temporarily.
2. Once the relative high is found, the algorithm checks for matches and clusters and 
   recognizes them if they are at least tritangent, the current angle is remembered.
3. Then all data older than the relative high is dropped.
4. The remaining data again is checked for a relative high, but starting with a range
   of <current angle> and -90.
5. that way 1-4 are repeated until less than 6 datapoints are left.

recognized tritangents are ready to processed further. They are specifically saved to be 
compared to later findings and to alert, when they are surpasssed by new data development.

in opposition to bitangents, there is no slopeshape, but only a slopetree, that manages 
the occurrences of the tritangents, informs of new findings, confirmations and excessions.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tritangent'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install tritangent

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tritangent.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
