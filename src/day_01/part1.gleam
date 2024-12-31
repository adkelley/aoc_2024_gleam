pub fn process(_input: String) -> String {
  "10"
}

pub fn example() -> Result(String, #(String, String)) {
  let input = ""
  let expected = "12"
  let result = process(input)
  case result == expected {
    True -> Ok(result)
    False -> Error(#(expected, result))
  }
}
