# aoc_2024_gleam

Advent of Code 2024 in Gleam. Besides reviewing and running my solutions, you can set up your own template and download the puzzle input data from the Advent of Code website `https://adventofcode.com`

## Usage

There are three commands, `create`, `test`, and `run`:

```bash
# Create the day 'x' and download the aoc data, where day = 1-25
gleam run -- create -d x 

# Run your solution using example day for day 'x', part 'y', 
# where day = 1-25, part = 1 or 2
gleam run -- test -d x -p y

# Run your solution using your aoc input data for day 'x', part 'y',
# where day = 1-25, part = 1 or 2
gleam run -- run -d x -p y
```

## Downloadng your Advent of Code puzzle data

When you create a day, this program will download your puzzle data from the advent of code website, and write it to `day_XX/inputY.txt` where `XX` is 1-25, and `Y` is 1 or 2.   But first, you'll need to access your AOC session cookie, and assign it to the environment variable `ADVENT_OF_CODE_SESSION_COOKIE`.

You can find SESSION by using Chrome tools:
1) Go to https://adventofcode.com/2022/day/1/input
2) right-click -> inspect -> click the "Application" tab.
3) Refresh
5) Click https://adventofcode.com under "Cookies"
6) Grab the value for session. 
7) Set the environment variable, `ADVENT_OF_CODE_SESSION_COOKIE` to the value

That is:

```shell
export ADVENT_OF_CODE_SESSION_COOKIE=value
```
