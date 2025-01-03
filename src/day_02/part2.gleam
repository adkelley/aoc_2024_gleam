import gleam/int
import gleam/list
import gleam/regexp
import gleam/string

fn lines(str: String) -> List(String) {
  str
  |> string.trim_end
  |> string.split("\n")
}

fn parse_line(input: String) -> List(Int) {
  let assert Ok(re) = regexp.from_string("\\s+")

  regexp.split(with: re, content: string.trim_end(input))
  |> list.filter_map(int.parse)
}

fn is_safe(report: List(Int)) -> Bool {
  list.window_by_2(report)
  |> fn(levels) {
    let diffs = list.map(levels, fn(t) { t.0 - t.1 })
    let all_increasing = list.all(diffs, fn(x) { x < 0 && x > -4 })
    let all_decreasing = list.all(diffs, fn(x) { x > 0 && x < 4 })
    all_increasing || all_decreasing
  }
}

fn is_safe_with_dampner(report: List(Int)) -> Bool {
  case is_safe(report) {
    True -> True
    False -> {
      list.index_map(report, fn(_x, i) { i })
      |> list.any(fn(i) {
        list.index_fold(report, [], fn(acc, t, index) {
          case i != index {
            True -> list.append(acc, [t])
            False -> acc
          }
        })
        |> is_safe
      })
    }
  }
}

pub fn process(input: String) -> String {
  lines(input)
  |> list.map(parse_line)
  |> list.filter(is_safe_with_dampner)
  |> list.length
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
  let expected = "4"
  let result = process(input)
  case result == expected {
    True -> Ok(result)
    False -> Error(#(expected, result))
  }
}
