from std/setutils import toSet

iterator subseq[T](s: openArray[T]; lo, hi: Natural): T =
  for i in lo..hi: yield s[i]

func findNDifferent(haystack: openArray[char]; N: int): int =
  var
    i = N
    cs = haystack.subseq(0, i-1).toSet()
  while i < haystack.high and cs.card < N:
    i.inc
    cs = haystack.subseq(i-N, i-1).toSet()
  return i

when isMainModule:
  let input = readfile("input/aoc06.txt")

  doAssert "bvwbjplbgvbhsrlpgdmjqwftvncz".findNDifferent(4) == 5
  doAssert "mjqjpqmgbljsphdztnvjfqwrcgsmlb".findNDifferent(14) == 19

  let p1 = input.findNDifferent(4)
  echo p1 # 1655

  let p2 = input.findNDifferent(14)
  echo p2 # 2665
