import zero_functional

func pri(c: char): int8 =
  (case c
  of 'a'..'z': c.ord - 'a'.ord + 1
  of 'A'..'Z': c.ord - 'A'.ord + 27
  else: -1).int8

func getAny[T](s: set[T]): T =
  for x in s: return x

template join[T](s: (set[T], set[T])): set[T] = s[0]+s[1]

func getCompartments(s: openArray[char]): (set[int8], set[int8]) =
  var c1, c2: set[int8]
  let med = s.high div 2
  for i in 0..med:
    c1.incl( s[i].pri )
    c2.incl( s[med+1+i].pri )
  (c1, c2)

when isMainModule:
  let input = lines("input/aoc03.txt") --> map(it.getCompartments)

  block Part1:
    let p1 = input --> map( getAny(it[0]*it[1]).int ).sum()
    echo p1 #7824

  block Part2:
    var i, p2: int = 0
    while i < input.len:
      p2.inc( getAny(
        input[i].join * input[i+1].join * input[i+2].join
      ))
      i.inc(3)
    echo p2 # 2798


#  block test:
#    const TEST = """vJrwpWtwJgWrhcsFMMfFFhFp
#jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
#PmmdzqPrVvPwwTWBwg
#wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
#ttgJtRGJQctTZtZT
#CrZsJsPPZsGzwwsLwLmpwMDw"""
