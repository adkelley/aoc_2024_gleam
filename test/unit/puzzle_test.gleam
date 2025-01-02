import day_01/part1 as d1p1
import day_01/part2 as d1p2

import gleeunit/should

pub fn d1p1_test() {
  d1p1.example()
  |> should.equal(Ok("11"))
}

pub fn d1p2_test() {
  d1p2.example()
  |> should.equal(Ok("31"))
}
