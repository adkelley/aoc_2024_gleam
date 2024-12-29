import argv
import clip
import clip/arg
import clip/help
import clip/opt
import gleam/io
import gleam/string

type Args {
  Args(cmd: Command, day: Int, part: Int)
}

type Command {
  Run
  Create
  Test
}

fn cmd_arg() {
  arg.new("cmd")
  |> arg.help("Command")
  |> arg.optional
  |> arg.try_map(fn(cmd) {
    case cmd {
      Ok("run") -> Ok(Run)
      Ok("create") -> Ok(Create)
      Ok("test") -> Ok(Test)
      _ -> Error("Command must be 'create', 'run', or 'test'")
    }
  })
}

fn day_opt() {
  opt.new("day")
  |> opt.short("d")
  |> opt.help("Day")
  |> opt.int
  |> opt.try_map(fn(day) {
    case day > 0 && day <= 25 {
      True -> Ok(day)
      False -> Error("Day must be between 1 and 25")
    }
  })
}

fn part_opt() {
  opt.new("part")
  |> opt.short("p")
  |> opt.help("Part")
  |> opt.int
  |> opt.try_map(fn(part) {
    case part > 0 && part <= 2 {
      True -> Ok(part)
      False -> Error("part must be 1 or 2")
    }
  })
}

fn command() {
  clip.command({
    use cmd <- clip.parameter
    use day <- clip.parameter
    use part <- clip.parameter

    Args(cmd, day, part)
  })
  |> clip.arg(cmd_arg())
  |> clip.opt(day_opt())
  |> clip.opt(part_opt())
}

pub fn main() {
  let result =
    command()
    |> clip.help(help.simple("aoc", "run aoc commands"))
    |> clip.run(argv.load().arguments)

  case result {
    Error(e) -> io.println_error(e)
    Ok(aoc) -> aoc |> string.inspect |> io.println
  }
}
