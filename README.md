# calendarium-romanum less-official data

This repository contains a collection of various sanctorale data files
(see [specification of their format][data])
in the format understood by the
[calendarium-romanum][caro] Ruby gem.

Unlike the data files packaged in the gem itself, there are no promises regarding correctness
of the data or their being up to date. While some of the data files may be updated by someone
from time to time, there is noone actively taking care of the whole.

## Contributions

are most welcome. Have you created a `calendarium-romanum` sanctorale data file
encoding the liturgical calendar of you country/diocese/order/...?
Share it with others!

## Usage

Copy the data file(s) of your choice to your project and load like this

```ruby
require 'calendarium-romanum/cr'

loader = CR::SanctoraleLoader.new

# load the data file
sanctorale = loader.load_from_file 'the-data-file.txt' # replace with path to your data file

# use the sanctorale data to build a calendar
calendar = CR::PerpetualCalendar.new(sanctorale: sanctorale)

# query the calendar
day = calendar[date]
p day.celebrations
```

## Directory Structure

`romcal_converted/` - data files created by converting data packaged
in the [romcal][romcal] JavaScript library.

## Contributing

* `bundle install` to get Ruby dependencies

In order to re-run the export of [romcal][romcal] data:

* `npm install` to get romcal and other JS dependencies
* `bundle exec rake -B` to run the export

In order to check data validity:

* `bundle exec rake spec`

[caro]: https://github.com/igneus/calendarium-romanum
[data]: https://github.com/igneus/calendarium-romanum/blob/master/data/README.md
[romcal]: https://github.com/romcal/romcal
