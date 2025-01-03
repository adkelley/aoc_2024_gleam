import day_01/part1 as d1p1
import day_01/part2 as d1p2
import day_02/part1 as d2p1
import day_02/part2 as d2p2

import gleeunit/should

pub fn d1p1_test() {
  d1p1.example()
  |> should.equal(Ok("11"))
}

pub fn d1p2_test() {
  d1p2.example()
  |> should.equal(Ok("31"))
}

pub fn d2p1_test() {
  d2p1.example()
  |> should.equal(Ok("2"))
}

pub fn d2p2_test() {
  d2p2.example()
  |> should.equal(Ok("4"))
}
