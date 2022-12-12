import std/[strutils, sequtils, setutils, tables, options, strformat, strscans, algorithm, pegs, sugar]
import zero_functional

const
  INPUTF = "input/aoc11.txt"
  MPeg = """\skip( \s* \n* )
s <- 'Monkey' num ':' 'Starting items:' items
  'Operation: new = old' op
  'Test: divisible by' {num}
  'If true: throw to monkey' {num}
  'If false: throw to monkey' {num}

op <- {[*+]} {num/'old'}
items <- {((num ',')* num)}
num <- \d+
"""
  INPUT = """Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1"""

type Monkey = object
  items: seq[int]
  op: proc(a: int): int {.closure.}
  test: int
  dir: tuple[t, f: Natural]
  inspected: Natural

proc main*(silent: bool = false) =
  #let input =  for l in INPUTF.splitLines():

  #let input = lines(INPUTF) --> map()
  var monkeys: seq[Monkey]
  #for m in INPUT.split("\n\n"):
  for m in readFile(INPUTF).split("\n\n"):
    if m =~ MPeg.peg:
      echo matches
      let
        items = matches[0].split(", ") --> map(parseInt(it))
        opchar = matches[1][0]
        op = try:
            let b = parseInt(matches[2])
            capture b:
              if opchar == '+': (proc(a: int): int = a + b)
              else: (proc(a: int): int = a * b)
          except:
            if opchar == '+': (proc(a: int): int = a + a)
            else: (proc(a: int): int = a * a)
        test = parseInt(matches[3])
        dir = (parseInt(matches[4]).Natural, parseInt(matches[5]).Natural)
        monkey = Monkey(items: items, op: op, test: test, dir: dir)
      monkeys.add(monkey)
    else: discard

  block part1:
    var monkeys = monkeys
    for round in 1..20:
      for m in monkeys.mitems:
        while m.items.len > 0:
          let item = m.items.pop()
          var wl = m.op(item) div 3
          if wl mod m.test == 0:
            monkeys[m.dir.t].items.add(wl)
          else:
            monkeys[m.dir.f].items.add(wl)
          m.inspected.inc()
    for m in monkeys:
      echo m.inspected

  echo "\n"

  block part2:
    var monkeys = monkeys
    let gcd = monkeys --> map(it.test).fold(1, a*it)
    echo gcd
    for round in 1..10000:
      for m in monkeys.mitems:
        while m.items.len > 0:
          let item = m.items.pop()
          var wl = m.op(item) mod gcd
          if wl mod m.test == 0:
            monkeys[m.dir.t].items.add(wl)
          else:
            monkeys[m.dir.f].items.add(wl)
          m.inspected.inc()
    for m in monkeys:
      echo m.inspected


when isMainModule:
  main()
