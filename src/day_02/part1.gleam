import gleam/function
import gleam/int
import gleam/list
import gleam/regexp
import gleam/result
import gleam/string

fn lines(str: String) -> List(String) {
  str
  |> string.trim_end
  |> string.split("\n")
}

fn parse_line(input: String) -> List(Int) {
  let assert Ok(re) = regexp.from_string("\\s+")

  regexp.split(with: re, content: string.trim_end(input))
  |> list.map(fn(x) { result.unwrap(int.parse(x), 0) })
}

fn satisfies_range(pairs: List(#(Int, Int))) -> Bool {
  list.map(pairs, fn(x) { int.absolute_value(x.1 - x.0) })
  |> list.all(fn(x) { x > 0 && x < 4 })
}

fn is_monotonic(pairs: List(#(Int, Int))) -> Bool {
  list.map(pairs, fn(x) { x.1 - x.0 })
  |> fn(xs) { list.all(xs, fn(x) { x < 0 }) || list.all(xs, fn(x) { x > 0 }) }
}

fn is_safe(levels: List(Int)) -> Bool {
  list.window_by_2(levels)
  |> fn(pairs) { is_monotonic(pairs) && satisfies_range(pairs) }
}

pub fn process(input: String) -> String {
  lines(input)
  |> list.map(parse_line)
  |> list.map(is_safe)
  |> list.filter(function.identity)
  |> list.length()
  |> int.to_string()
}

pub fn example() -> Result(String, #(String, String)) {
  let input =
    "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"
  let expected = "2"
  let result = process(input)
  case result == expected {
    True -> Ok(result)
    False -> Error(#(expected, result))
  }
}
