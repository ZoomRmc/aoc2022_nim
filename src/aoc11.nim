import std/[strutils, sugar, pegs]
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

type Monkey = object
  items: seq[int]
  op: proc(a: int): int {.closure.}
  test: int
  dir: array[bool, Natural]
  inspected: Natural

proc simulate(monkeys: seq[Monkey]; rounds: Natural; p1: static bool = true): Natural =
  var monkeys = monkeys
  when not p1:
    let lcm = monkeys --> map(it.test).fold(1, if a mod it != 0: a*it else: it) # not quite!
  for round in 1..rounds:
    for m in monkeys.mitems:
      while m.items.len > 0:
        let item = m.items.pop()
        var wl = when p1: m.op(item) div 3 else: m.op(item) mod lcm
        monkeys[m.dir[wl mod m.test == 0]].items.add(wl) # ordinal-indexed arrays are cool!
        m.inspected.inc()
  (monkeys --> map(it.inspected).fold([0.Natural, 0],
    if it > a[0]: [it, a[0]]
    elif it > a[1]: [a[0], it]
    else: a)) --> product()

proc main*() =
  var monkeys: seq[Monkey]
  for m in readFile(INPUTF).split("\n\n"):
    if m =~ MPeg.peg:
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
        dir = [parseInt(matches[5]).Natural, parseInt(matches[4]).Natural] # false goes first
        monkey = Monkey(items: items, op: op, test: test, dir: dir)
      monkeys.add(monkey)

  block part1:
    let p1 = monkeys.simulate(20)
    echo p1 # 120056

  block part2:
    let p2 = monkeys.simulate(10000, false)
    echo p2 # 21816744824

when isMainModule:
  main()
