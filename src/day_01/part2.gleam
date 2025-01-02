import gleam/dict
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

pub fn process(input: String) -> String {
  let #(left, right): #(List(Int), List(Int)) =
    input |> lines |> list.map(parse_line) |> list.unzip()

  let d =
    list.fold(right, dict.new(), fn(d, i) {
      case dict.get(d, i) {
        Ok(x) -> dict.insert(d, i, x + 1)
        Error(Nil) -> dict.insert(d, i, 1)
      }
    })

  list.fold(left, 0, fn(acc, i) {
    case dict.get(d, i) {
      Ok(x) -> acc + i * x
      Error(Nil) -> acc
    }
  })
  |> int.to_string()
}

pub fn example() -> Result(String, #(String, String)) {
  let input =
    "3   4
4   3
2   5
1   3
3   9
3   3"
  let expected = "31"
  let result = process(input)
  case result == expected {
    True -> Ok(result)
    False -> Error(#(expected, result))
  }
}
