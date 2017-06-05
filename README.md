# progressbar [![build][build-img]][build-url]

A pacman like progress bar in bash, it  aims to provide an quick and easy to use
progress bar to put in your shell code.

<!-- TODO:
 - Complete examples script: from the simpliest to the more complex using external  bash enviterator as increment. Also do an example script that look like pacman
 - Create a small static website (with hugo) in https://pujol.gitlab.io/progressbar -->


**Features**

This progressbar supports the following features:
* `ILoveCandy` option to have progress bar like pacman does.
* Personalize and create your own progress bar theme.


## Installation

No installation is needed, just place the `progressbar.sh` file in your working
directory and enjoy!
```sh
curl https://raw.githubusercontent.com/roddhjav/progressbar/master/progressbar.sh > progressbar.sh
```

However if you want to run the test, you need to clone this repository:
```sh
git clone https://github.com/roddhjav/progressbar
cd progressbar
make test
```

## Usage
To use the progressbar, you just need to source it in your bash script. `progressbar` is a bash function that tajes up to 6 arguments:

1. `title` Bar title *(mandatory)*
2. `current` Current progress of the bar *(mandatory)*
3. `total` Total bar progress *(mandatory)*
4. `msg1`, `msg2`, `msg3` *(optional)*

**Example:**
```sh
#!/bin/bash

# Loading progressbar
source progressbar.sh || exit 1

local _ii _start=0 _end=25
for _ii in $(seq ${_start} ${_end}); do
    sleep 0.1
    progressbar "My progress bar" ${_ii} ${_end}
done
echo
```
```
 My progress bar                   [###############################] 100%
```


## Themes

There are two themes provided:
1. The default theme used by pacman,
2. The ILoveCandy theme also available in pacman, you can use it with the option `ILoveCandy=true`

Moreover, you can change the following variables to set your own themes. The following table sum up the values used.

|                 | Default | ILoveCandy |
|-----------------|:-------:|:----------:|
| Braket_in       |   `[`   |     `[`    |
| Braket_out      |   `]`   |     `]`    |
| Cursor_done     |   `#`   |     `-`    |
| Cursor_not_done |   `-`   |    `o  `   |
| Cursor          |         |     `C`    |
| Cursor_small    |         |     `C`    |


## Contribution
Feedback, contributors, pull requests are all very welcome.


## License

    Copyright (C) 2016 - 2017 Alexandre PUJOL

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

[build-img]: https://travis-ci.org/roddhjav/progressbar.svg?branch=master
[build-url]: https://travis-ci.org/roddhjav/progressbar
