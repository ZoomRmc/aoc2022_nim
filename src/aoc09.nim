import std/[sets, strutils]
import zero_functional

const
  INPUTF = "input/aoc09.txt"
  LEN = 10

type
  Dir = enum U, D, L, R
  Cmd = tuple[d: Dir, n: int]

func `+`(a, b: (int, int)): (int, int) = (a[0]+b[0], a[1]+b[1])
func `-`(a, b: (int, int)): (int, int) = (a[0]-b[0], a[1]-b[1])

func lim(a: int): int =
  if a < 0: -1
  elif a > 0: 1
  else: 0

func toStep(dir: Dir; n: Positive = 1): (int, int) =
  case dir
    of U: (0, 1*n)
    of D: (0, -1*n)
    of L: (-1*n, 0)
    of R: (1*n, 0)

func simulate(input: seq[Cmd]; len: static Natural): int =
  var
    visited: HashSet[(int, int)] = toHashSet([(0, 0)])
    rope: array[len, (int, int)]
  for (dir, n) in input:
    rope[0] = rope[0] + dir.toStep(n)
    for i in 0..<n:
      for i in 1..<len:
        let diff = rope[i-1] - rope[i]
        if diff == (0, 0): break
        if diff[0].abs > 1 or diff[1].abs > 1:
          rope[i] = rope[i]+( diff[0].lim(), diff[1].lim() )
      visited.incl(rope[^1])
  visited.card

proc main*(silent: bool = false) =
  let input: seq[Cmd] =
    lines(INPUTF) --> map(block:
    let d = case it[0]
      of 'U': U
      of 'D': D
      of 'L': L
      else: R
    (d, parseInt(it.substr(2, it.high)))
  )

  block Part1:
    let p1 = simulate(input, 2)
    echo p1 # 6026

  block Part2:
    let p2 = simulate(input, LEN)
    echo p2 # 2273

when isMainModule:
  main()
