# safer_dates

This library allows users to strictly enforce ISO 8601 date and datetime
parsing in Ruby.

## Usage

In your `Gemfile`:

```ruby
gem 'safer_dates'
```

or at the command line:

```sh
$ gem install safer_dates
```

In your ruby program you choose which functionality to enable by requiring different files. The options are:

```ruby
require 'safer_dates/enforcers/date_dot_parse.rb'
require 'safer_dates/enforcers/datetime_dot_parse.rb'
require 'safer_dates/enforcers/attribute_typecasting.rb'

require 'safer_dates/parsers/datetime_parser.rb'
require 'safer_dates/parsers/date_parser.rb'
```

## Examples

```ruby
require 'date'

> Date.parse('10/12/1999')
=> #<Date: 1999-12-10 ((2451523j,0s,0n),+0s,2299161j)>

> require 'safer_dates/enforcers/date_dot_parse.rb'
=> false

> Date.parse('10/12/1999')
=> THROWS ERROR

# and similar behavior for datetimes when using `require 'safer_dates/enforcers/datetime_dot_parse.rb'`
```

```ruby
# using Rails and/or activerecord

> class Foo < ActiveRecord::Base
>  # has attribute called `start_date` that maps to a database column of type date
> end
=> nil

> Foo.new(start_date: 'invalid')
=> #<Foo start_date: nil>

> Foo.new(start_date: '25/01/1999')
=> #<Foo start_date: "1999-01-25">

require 'safer_dates/enforcers/attribute_typecasting'

> Foo.new(start_date: 'invalid')
=> RAISES ERROR

> Foo.new(start_date: '25/01/1999')
=> RAISES ERROR

> Foo.new(start_date: '1999-01-25')
=> # Works

> Foo.new(start_date: Date.new(1999, 01, 25))
=> # Works
```


```ruby
require 'safer_dates/parsers/date_parser.rb'

> DateParser.p('10/01/1999')
=> RAISES ERROR

> DateParser.p('1999-01-10')
=> # Works
```

```ruby
require 'safer_dates/parsers/datetime_parser.rb'
> DateTimeParser.p('10/01/1999 11:10:00')
=> RAISES ERROR

> DateTimeParser.p('1999-10-01 11:10:00')
=> # Works
```

## Acknowledgments

The ISO 8601 regexes and date/datetime instantiation logic was originally taken
from rails/activerecord source code.
