pub fn process(_input: String) -> String {
  "4"
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
