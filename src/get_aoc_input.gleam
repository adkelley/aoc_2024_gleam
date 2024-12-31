import gleam/http/request
import gleam/httpc
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleeunit/should
import glenvy/env
import simplifile

pub type Error {
  WriteInputDataError(simplifile.FileError)
}

pub fn day_dirname(day: Int) -> String {
  case day < 10 {
    True -> "day_0" <> int.to_string(day)
    False -> "day_" <> int.to_string(day)
  }
}

pub fn get_aoc_input(day: Int) -> Result(Nil, Error) {
  // Get the aoc session cookie
  let assert Ok(session_cookie) =
    env.get_string("ADVENT_OF_CODE_SESSION_COOKIE")

  let url =
    "https://adventofcode.com/2024/day/" <> int.to_string(day) <> "/input"
  io.println("Sending to " <> url)

  let assert Ok(base_req) = request.to(url)

  let req = request.set_cookie(base_req, "session", session_cookie)

  let assert Ok(resp) = httpc.send(req)

  // TODO need better error handling
  resp.status |> should.equal(200)

  let input_data = resp.body

  let path1 = "./src/" <> day_dirname(day) <> "/input1.txt"
  let path2 = "./src/" <> day_dirname(day) <> "/input2.txt"

  list.try_each([path1, path2], simplifile.write(_, input_data))
  |> result.map_error(WriteInputDataError)
}
