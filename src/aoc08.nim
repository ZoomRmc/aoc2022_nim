import std/[setutils, tables, algorithm, sets]
import zero_functional

const
  INPUTF = "input/aoc08.txt"
  SIZE = 99
  edgeC = 4 * (SIZE-1)

type
  Tree = int8
  Map[T] = array[SIZE*SIZE, T]

func `{}`[T](s: openArray[T], p: tuple[y: int, x: int]): T =
  s[p.y * SIZE + p.x]

proc `{}=`[T](s: var openArray[T], p: tuple[y: int, x: int]; v: T) =
  s[p.y * SIZE + p.x] = v

iterator circ(n: int): (int, int) =
  for i in n..<SIZE-n-1:
    for p in [ (n, i), (i, SIZE-n-1), (SIZE-n-1, SIZE-i-1), (SIZE-i-1, n) ]:
      yield p

proc fillVMapRC(vmap: var Map[bool]; map: Map[int]; hor: static bool) =
  template markIfVisible(i, rc: int; max: var int) =
    let pt = when hor: (rc, i) else: (i, rc)
    let h = map{pt}
    if h > max:
      vmap{pt} = true
      max = h

  for rc in 1..SIZE-2:
    var (maxA, maxB) = when hor: (map{(rc, 0)}, map{(rc, SIZE-1)})
      else: (map{(0, rc)}, map{(SIZE-1, rc)})
    var i = 1
    while i < SIZE-1 and maxA < 9:
      markIfVisible(i, rc, maxA)
      i.inc()
    i = SIZE-2
    while i > 0 and maxB < 9:
      markIfVisible(i, rc, maxB)
      i.dec()

func scenicScore(map: Map[int]; p: tuple[y: int, x: int]): int =
  let height = map{p}
  var
    l, r, t, b = 0
  for i in countDown(p.x-1, 0):
    let h = map{(p.y, i)}
    l.inc
    if h >= height: break
  for i in p.x+1..SIZE-1:
    let h = map{(p.y, i)}
    r.inc
    if h >= height: break
  for i in countDown(p.y-1, 0):
    let h = map{(i, p.x)}
    t.inc
    if h >= height: break
  for i in p.y+1..SIZE-1:
    let h = map{(i, p.x)}
    b.inc
    if h >= height: break
  #debugecho "y:", p.y, " x:",p.x, " ", l, r,  t,  b
  l * r * t * b

proc main*(silent: bool = false) =
  var map: Map[int]

  let input = lines(INPUTF) --> to(seq[string])
  for y in 0..<SIZE:
    for x in 0..<SIZE:
      map{(y, x)} = int8(ord(input[y][x]) - '0'.ord)

  block part1:
    var vmap: Map[bool]
    for n in 0..<SIZE:
      vmap.fillVMapRC(map, true)
      vmap.fillVMapRC(map, false)
    let p1 = edgeC + (vmap --> map(it.ord()).sum())
    echo p1 # 1703

  block part2:
    var maxScenicScore = 0
    for n in 1..(SIZE div 2):
      for p in circ(n):
        let score = scenicScore(map, p)
        if score > maxScenicScore: maxScenicScore = score
    if SIZE mod 2 == 1:
      let c = (SIZE div 2) + (SIZE mod 2)
      let score = scenicScore(map, (c, c))
      if score > maxScenicScore: maxScenicScore = score
    echo maxScenicScore # 496650

when isMainModule:
  main()
