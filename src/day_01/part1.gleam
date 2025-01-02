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

fn parse_line(input: String) -> #(Int, Int) {
  let assert Ok(re) = regexp.from_string("\\s+")
  let parts = regexp.split(with: re, content: string.trim_end(input))
  case parts {
    [left, right] -> #(
      result.unwrap(int.parse(left), 0),
      result.unwrap(int.parse(right), 0),
    )
    _ -> panic as "error"
  }
}

fn total_distance(list_t: #(List(Int), List(Int))) -> List(Int) {
  let #(left, right) = list_t
  list.map2(
    list.sort(left, by: int.compare),
    list.sort(right, by: int.compare),
    fn(a, b) { int.absolute_value(a - b) },
  )
}

pub fn process(input: String) -> String {
  input
  |> lines
  |> list.map(parse_line)
  |> list.unzip
  |> total_distance
  |> int.sum
  |> int.to_string
}

pub fn example() -> Result(String, #(String, String)) {
  let input =
    "3   4
4   3
2   5
1   3
3   9
3   3"
  let expected = "11"
  let result = process(input)
  case result == expected {
    True -> Ok(result)
    False -> Error(#(expected, result))
  }
}
