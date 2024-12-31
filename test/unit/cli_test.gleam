import cli.{Create, One, Run, Test, Two, cli_command}
import gleeunit/should

pub fn create_cmd_test() {
  ["create", "-d", "1"]
  |> cli_command
  |> should.equal(Ok(Create(1)))
}

pub fn run_cmd_test() {
  ["run", "-d", "1", "-p", "1"]
  |> cli_command
  |> should.equal(Ok(Run(1, One)))
}

pub fn test_cmd_test() {
  let result =
    ["test", "-d", "1", "-p", "2"]
    |> cli_command

  result
  |> should.equal(Ok(Test(1, Two)))
}

pub fn day_fail_1_test() {
  ["create", "-d", "26"]
  |> cli_command
  |> should.be_error
}

pub fn day_fail_2_test() {
  ["create", "-d", "0"]
  |> cli_command
  |> should.be_error
}

pub fn part_fail_1_test() {
  ["run", "-d", "25", "-p", "0"]
  |> cli_command
  |> should.be_error
}

pub fn part_fail_2_test() {
  ["run", "-d", "25", "-p", "3"]
  |> cli_command
  |> should.be_error
}
