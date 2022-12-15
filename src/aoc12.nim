import std/[enumerate, sets, deques]

const INPUTF = "input/aoc12.txt"

type
  Point = tuple[y, x:int]
  D = enum W, N, E, S

func `{}`[T](s: openArray[seq[T]], p: Point): T =
  s[p.y][p.x]

iterator neighbours(p: Point; w, h: int): Point = 
  var dirs: set[D]
  if p.x > 0: dirs.incl W
  if p.y > 0: dirs.incl N
  if p.x < w-1: dirs.incl E
  if p.y < h-1: dirs.incl S
  let dPs = [(y: p.y, x:p.x-1), (y:p.y-1, x:p.x), (y:p.y, x:p.x+1), (y:p.y+1, x:p.x)]
  for d in dirs:
    yield dPs[d.ord]
    

proc solve(map: openArray[seq[int8]]; start, dest: Point; part2: bool = false): int =
  var
    seen: HashSet[Point]
    queue = [(dest, 0)].toDeque()

  while queue.len > 0:
    let (cur, steps) = queue.popFirst()
    if map{cur} == 0 and (part2 or cur == start):
      return steps
    for n in neighbours(cur, map[0].len, map.len):
      if n notin seen and map{n} >= map{cur} - 1:
        seen.incl(n)
        queue.addLast((n, steps+1))

proc main*() =
  var
    map: seq[seq[int8]]
    start, dest: Point
  for (r, l) in enumerate(lines(INPUTF)):
    var row: seq[int8]
    for (c, ch) in enumerate(l):
      case ch:
        of 'a'..'z': row.add(ch.ord.int8 - 'a'.ord)
        of 'S': row.add(0.int8); start = (y:r, x:c)
        of 'E': row.add(25); dest = (y:r, x:c)
        else: discard
    map.add(row)

  block part1:
    let p1 = map.solve(start, dest)
    echo p1 # 504
   
  block part2:
    let p2 = map.solve(start, dest, true)
    echo p2 # 500

when isMainModule:
  main()
