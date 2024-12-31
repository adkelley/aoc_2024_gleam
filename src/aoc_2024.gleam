import argv
import gleam/result
import simplifile

import gleam/io
import gleam/string

import cli.{type Part, Create, One, Run, Test, Two}
import get_aoc_input.{day_dirname, get_aoc_input}

import day_01/part1 as day1part1
import day_01/part2 as day1part2

pub type Error {
  CopyTemplateError(simplifile.FileError)
  ReadInputError(simplifile.FileError)
  DayExistsError
  AocInputError(get_aoc_input.Error)
  ExampleError(#(String, String))
  NoDayError
}

fn copy_template_files(day: Int) -> Result(Nil, Error) {
  let path = "src/" <> day_dirname(day)
  let template_dir = "./daily_template"
  case simplifile.is_directory(path) {
    // If the directory already exists, don't reset it
    Ok(True) -> Error(DayExistsError)
    // Try copying the template files
    Ok(False) ->
      simplifile.copy_directory(template_dir, path)
      |> result.map_error(CopyTemplateError)
    Error(e) -> Error(CopyTemplateError(e))
  }
}

fn create_day_puzzle(day: Int) -> Result(Nil, Error) {
  copy_template_files(day)
  |> result.then(fn(_) { get_aoc_input(day) |> result.map_error(AocInputError) })
}

fn part_example(
  part: Part,
  part1: fn() -> Result(String, #(String, String)),
  part2: fn() -> Result(String, #(String, String)),
) -> Result(String, Error) {
  case part {
    One -> part1() |> result.map_error(ExampleError)
    Two -> part2() |> result.map_error(ExampleError)
  }
}

fn test_day_example(day: Int, part: Part) -> Result(String, Error) {
  case day {
    1 -> part_example(part, day1part1.example, day1part2.example)
    _ -> Error(NoDayError)
  }
}

fn part_process(
  day: String,
  part: Part,
  part1: fn(String) -> String,
  part2: fn(String) -> String,
) -> Result(String, Error) {
  case part {
    One -> {
      use data <- result.try(
        simplifile.read("src/" <> day <> "/input1.txt")
        |> result.map_error(ReadInputError),
      )
      Ok(part1(data))
    }
    Two -> {
      use data <- result.try(
        simplifile.read("src/" <> day <> "/input2.txt")
        |> result.map_error(ReadInputError),
      )
      Ok(part2(data))
    }
  }
}

fn run_day_process(day: Int, part: Part) -> Result(String, Error) {
  case day {
    1 ->
      part_process(day_dirname(day), part, day1part1.process, day1part2.process)
    _ -> Error(NoDayError)
  }
}

pub fn main() {
  let result = cli.cli_command(argv.load().arguments)

  case result {
    Error(e) -> io.println_error(e)
    Ok(aoc) ->
      case aoc {
        Create(day) -> create_day_puzzle(day) |> string.inspect |> io.println
        Test(day, part) ->
          test_day_example(day, part) |> string.inspect |> io.println
        Run(day, part) ->
          run_day_process(day, part) |> string.inspect |> io.println
      }
  }
}
