import std/[strutils, sequtils, setutils, tables, options, strformat, strscans, algorithm, sets]
import zero_functional

const
  INPUTF = "input/aoc08.txt"
  SIZE = 99
  edgeC = 4 * (SIZE-1)

type
  Tree = int8
  Map = array[SIZE*SIZE, Tree]

func `{}`[T](s: openArray[T], p: tuple[y: int, x: int]): T =
  s[p.y * SIZE + p.x]

func `{}=`[T](s: var openArray[T], p: tuple[y: int, x: int]; v: T) =
  s[p.y * SIZE + p.x] = v

iterator circ(n: int): (int, int) =
  for i in n..<SIZE-n-1:
    for p in [ (n, i), (i, SIZE-n-1), (SIZE-n-1, SIZE-i-1), (SIZE-i-1, n) ]:
      yield p

func isVisible(map: Map; p: tuple[y: int, x: int]): bool =
  let height = map{p}
  var
    maxl, maxr, maxt, maxb = 0
    vis = (true, true, true, true)
  for i in 0..<p.x:
    let h = map{(p.y, i)}
    if h > maxl: maxl = h
    if maxl >= height:
      vis[0] = false
      break
  for i in countDown(SIZE-1, p.x+1):
    let h = map{(p.y, i)}
    if h > maxr: maxr = h
    if maxr >= height:
      vis[1] = false
      break
  for i in 0..<p.y:
    let h = map{(i, p.x)}
    if h > maxt: maxt = h
    if maxt >= height:
      vis[2] = false
      break
  for i in countDown(SIZE-1, p.y+1):
    let h = map{(i, p.x)}
    if h > maxb: maxb = h
    if maxb >= height:
      vis[3] = false
      break
  #debugecho "r:", r, " c:",c, " ", (vis[0] or vis[1] or vis[2] or vis[3])
  vis[0] or vis[1] or vis[2] or vis[3]

func scenicScore(map: Map; p: tuple[y: int, x: int]): int =
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
  var map: Map

  let input = lines(INPUTF) --> to(seq[string])
  for y in 0..<SIZE:
    for x in 0..<SIZE:
      map{(y, x)} = int8(ord(input[y][x]) - '0'.ord)

  block Part1:
    var totalvisible = edgeC
    for n in 1..(SIZE div 2):
      for p in circ(n):
        totalvisible.inc(map.isVisible(p).ord)
    if SIZE mod 2 == 1:
      let c = (SIZE div 2) + (SIZE mod 2)
      totalvisible.inc( map.isVisible((c,c)).ord )
    echo totalvisible # 1703

  block Part2:
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
