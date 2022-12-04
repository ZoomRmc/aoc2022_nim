import std/[strscans], zero_functional

type rng = tuple[lo, hi:int]

func contains(a: rng; b: rng): bool =
  b.lo >= a.lo and b.hi <= a.hi

func overlaps(a: rng; b: rng): bool =
  (b.lo in a.lo..a.hi) or (b.hi in a.lo..a.hi) or
  (b.lo <= a.lo and b.hi >= a.hi)

when isMainModule:
  let input = lines("input/aoc04.txt") --> map(block:
    let (_, a, b, c, d) = scanTuple(it, "$i-$i,$i-$i")
    ( (a, b).rng, (c, d).rng )
  )

  block Part1:
    let p1 = input --> map((r1, r2) = it).map(
      ord(r1.contains(r2) or r2.contains(r1)) ).sum()
    echo p1 # 500

  block Part2:
    let p2 = input --> map((r1, r2) = it).map(
      ord(r1.overlaps(r2)) ).sum()
    echo p2 # 815
