import clip

import clip/help
import clip/opt

pub type Part {
  One
  Two
}

pub type Args {
  Create(day: Int)
  Run(day: Int, part: Part)
  Test(day: Int, part: Part)
}

fn create_cmd() {
  clip.command({
    use day <- clip.parameter

    Create(day)
  })
  |> clip.opt(day_opt())
}

fn run_cmd() {
  clip.command({
    use day <- clip.parameter
    use part <- clip.parameter

    Run(day, part)
  })
  |> clip.opt(day_opt())
  |> clip.opt(part_opt())
}

fn test_cmd() {
  clip.command({
    use day <- clip.parameter
    use part <- clip.parameter

    Test(day, part)
  })
  |> clip.opt(day_opt())
  |> clip.opt(part_opt())
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
    case part {
      1 -> Ok(One)
      2 -> Ok(Two)
      _ -> Error("part must be 1 or 2")
    }
  })
}

fn command() {
  clip.subcommands([
    #("create", create_cmd()),
    #("run", run_cmd()),
    #("test", test_cmd()),
  ])
}

pub fn cli_command(arguments: List(String)) -> Result(Args, String) {
  command()
  |> clip.help(help.simple("aoc", "run aoc commands"))
  |> clip.run(arguments)
}
