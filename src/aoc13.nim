import std/[algorithm]
import zero_functional

const
  INPUTF = "input/aoc13.txt"

type
  Signal {.acyclic.} = object
    case isNum: bool
    of true:
        num: int
    of false:
        elems: seq[Signal]

proc `$`(s: Signal): string =
  if s.isNum: $s.num
  else: $s.elems

func toSignal(n: int): Signal = Signal(isNum: true, num:n)
func toSignal(s: seq[Signal]): Signal =
  Signal(isNUm: false, elems: s)

proc parseSignal(s: openArray[char]): (Signal, int) =
  var
    i = 0
    rs: Signal
    inside = false
  while i < s.len:
    case s[i]
      of '[':
        if not inside:
          rs.isNum = false
          i.inc()
        else:
          let (ns, len) = s.toOpenArray(i, s.high).parseSignal()
          rs.elems.add(ns)
          i.inc(len)
        inside = true
      of '0'..'9':
        var ns = Signal(isNum: true, num: 0)
        while s[i] in '0'..'9':
          ns.num = ns.num*10 + (s[i].ord - '0'.ord)
          i.inc()
        rs.elems.add(ns)
      of ']':
        i.inc()
        break
      else:
        i.inc()
  (rs, i)

proc cmp(a, b: Signal): int =
  if a.isNum:
    if b.isNum:
      return a.num - b.num
    else:
      return cmp(Signal(isNum:false, elems: @[a]), b)
  else:
    if b.isNum:
      return cmp(a, Signal(isNum:false, elems: @[b]))
    else:
      for i in 0..<min(a.elems.len, b.elems.len):
        let r = cmp(a.elems[i], b.elems[i])
        if r != 0:
          return r
      return a.elems.len - b.elems.len

proc main*() =
  var input = lines(INPUTF) --> filter(it != "")
    .map(it.parseSignal()[0])

  block part1:
    let p1 = countUp(0, input.len-1, 2) -->
      filter(cmp(input[it], input[it+1]) < 0)
      .map(it div 2 + 1).sum()
    echo p1 # 5529

  block part2:
    let d2 = @[toSignal(2)].toSignal()
    let d6 = @[toSignal(6)].toSignal()
    input.add(d2)
    input.add(d6)
    sort(input, cmp)
    let (d2i, d6i) = (input.binarySearch(d2, cmp), input.binarySearch(d6, cmp))
    let p2 = (d2i + 1) * (d6i + 1)
    echo p2 # 27690

when isMainModule:
  main()
