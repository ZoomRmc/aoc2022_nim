from std/strutils import parseInt
import zero_functional

const
  INPUTF = "input/aoc10.txt"
  WIDTH = 40
  HEIGHT = 6

func toString(a: openArray[char]; first: int = 0; last: int = a.high): string =
  for ci in first..last: result.add(a[ci])

proc main*() =
  var
    x = 0 # no thanks, we'll track the sprite's start
    cycles: seq[int]
    crt: array[WIDTH*HEIGHT, char]
  for s in lines(INPUTF):
    if s[0] == 'n':
      cycles.add(x)
    else:
      let n = parseInt(s.substr(5, s.high))
      cycles.add(x)
      cycles.add(x)
      x.inc(n)

  block part1:
    var strTotal = 0
    for i in countUp(20, 220, 40):
      strTotal.inc(i * (cycles[i-1] + 1))
    echo strTotal # 12880

  block part2:
    for (px, offset) in cycles --> enumerate():
      x = ((px div WIDTH) * WIDTH) + offset
      #echo "CRT draws at", px, " sprite:", x, ",", x+1,",", x+2
      crt[px] = if px in [x, x+1, x+2]: '#' else: '.'

    for i in countUp(0, 200, 40):
      echo crt.toString(i, i+39)

when isMainModule:
  main()
