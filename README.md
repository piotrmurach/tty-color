# TTY::Color
[![Gem Version](https://badge.fury.io/rb/tty-color.svg)][gem]
[![Build Status](https://secure.travis-ci.org/peter-murach/tty-color.svg?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/peter-murach/tty-color/badges/gpa.svg)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/peter-murach/tty-color/badge.svg)][coverage]
[![Inline docs](http://inch-ci.org/github/peter-murach/tty-color.svg?branch=master)][inchpages]

[gem]: http://badge.fury.io/rb/tty-color
[travis]: http://travis-ci.org/peter-murach/tty-color
[codeclimate]: https://codeclimate.com/github/peter-murach/tty-color
[coverage]: https://coveralls.io/r/peter-murach/tty-color
[inchpages]: http://inch-ci.org/github/peter-murach/tty-color

> Terminal color capabilities detection.

**TTY::Color** provides independent color support detection component for [TTY](https://github.com/peter-murach/tty) toolkit.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tty-color'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tty-color

## Usage

**TTY::Color** allows you to check if terminal supports color:

```ruby
TTY::Color.color?     # => true
TTY::Color.supports?  # => true
```

Also you can get the number of colors supported by the terminal:

```ruby
TTY::Color.mode # => 64
```

**TTY::Color** is just a module hence you can include it into your scripts directly:

```ruby
#!/usr/bin/env ruby

include TTY::Color

puts color?
```

## Command line tool

[tty-color-cli](https://github.com/peter-murach/tty-color-cli) is a command line tool for the **TTY::Color**.

To check if terminal supports colors do:

```bash
color -s
```

and to check color mode:

```bash
color -m
```

## Contributing

1. Fork it ( https://github.com/peter-murach/tty-color/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

Copyright (c) 2016 Piotr Murach. See LICENSE for further details.
