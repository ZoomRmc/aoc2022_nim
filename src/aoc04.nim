import std/[strscans], zero_functional

func contains(a, b: HSlice[int, int]): bool =
  b.a >= a.a and b.b <= a.b

func overlaps(a, b: HSlice[int, int]): bool =
  b.a <= a.b and b.b >= a.a

when isMainModule:
  let input = lines("input/aoc04.txt") --> map(block:
    let (_, a, b, c, d) = scanTuple(it, "$i-$i,$i-$i")
    (a..b, c..d)
  )

  block Part1:
    let p1 = input -->
      map( ord(it[0].contains(it[1]) or it[1].contains(it[0])) ).sum()
    echo p1 # 500

  block Part2:
    let p2 = input -->
      map( ord(it[0].overlaps(it[1])) ).sum()
    echo p2 # 815
