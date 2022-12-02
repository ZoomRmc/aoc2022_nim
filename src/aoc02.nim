import zero_functional

# This is how you derive it when you're not very smart:
# R = 0, P = 1, S = 2
# w    0-2  1-0 2-1     -2, 1, 1
# d    0-0  1-1 2-2      0, 0, 0
# l    0-1  1-2 2-0     -1,-1, 2
# => (a - b + 4) mod 3;  same for the second part

when isMainModule:
  let input = lines("input/aoc02.txt") --> map(
    ( ord(it[2]) - ord('X'), ord(it[0]) - ord('A') )
  )

# This is how you'd think you should solve it:
  block Part1:
    let p1 = input --> map((you, op) = it).
      map( ((you - op + 4) mod 3) * 3 + (you+1) ).sum()
    echo p1 #13221

  block Part2:
    let p2 = input --> map((r, op) = it).
      map( ((op + (r-1) + 3) mod 3 + 1) + (r*3) ).sum()
    echo p2 #13131

# And this is how you really should:
  block test:
    const
      ScoreTable = [ # you->op
        [3, 0, 6], # rock
        [6, 3, 0], # paper
        [0, 6, 3], # scissors
      ]
      MoveTable = [ # result->op
        [3, 1, 2], # lose
        [1, 2, 3], # draw
        [2, 3, 1], # win
      ]
    let p1 = input --> map((you, op) = it).map(ScoreTable[you][op] + you+1).sum()
    doAssert p1 == 13221
    let p2 =  input --> map((r, op) = it).map(MoveTable[r][op] + r*3).sum()
    doAssert p2 == 13131
