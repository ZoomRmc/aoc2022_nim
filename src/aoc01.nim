import zero_functional
import std/[strutils]

const LEN = 3

## Add a number to an array keeping the elements sorted in reversed descending order
proc pushMax(a: var openArray[int]; n: int) =
  var
    n = n
    i = a.high()
  while i >= 0 and n <= a[i]: i.dec()
  if i > 0:
    for j in countDown(i, 0):
      swap(n, a[j])

when isMainModule:
  var
    i: int
    ms: array[LEN, int]
  for line in lines("input/aoc01.txt"):
    if line != "":
      i.inc(line.parseInt())
    else:
      ms.pushMax(i)
     # # `pushMax` is excessive, the following works just fine:
     # ms = if i > ms[2]: [ms[1], ms[2], i]
     #   elif i > ms[1]: [ms[1], i, ms[2]]
     #   elif i > ms[0]: [i, ms[1], ms[2]]
     #   else: ms
      i = 0

  block Part1:
    echo ms[LEN-1] #70116

  block Part2:
    echo ms --> sum() #206582

#------------------------------------------------------------------------------
  block Test:
    var t = [1, 2, 3, 3]
    doAssert (t.pushMax(3); t) == [2, 3, 3, 3]
    doAssert (t.pushMax(4); t) == [3, 3, 3, 4]
