import std/[strscans], zero_functional

{.experimental: "views".}

type Cmd = tuple[q, src, dst: int]

func getTops(s: seq[seq[char]]): string =
  s --> map(it[^1]).fold("", (a.add(it); a))

func lastN[T](s: openArray[T]; n: Natural): openArray[T] =
  s.toOpenArray(s.len - n, s.high)

func reversedTrim[T](a: openArray[T]): seq[T] {.inline.} =
  for i in countDown(a.len - 1, 0):
    if a[i] == ' ': break else: result.add(a[i])

when isMainModule:
  let (cmds, inputStacks) = block:
    var
      cmds: seq[Cmd]
      rawStacks: seq[seq[char]]
      header = true
    for l in lines("input/aoc05.txt"):
      if l == "": header = false; continue
      if header:
        var i = l.len - 2
        if l[i] notin 'A'..'Z': continue
        else:
          while i >= 1:
            let stackIdx = i div 4
            while rawStacks.len < stackIdx + 1: rawStacks.add(@[])
            rawStacks[stackIdx].add(l[i])
            i.dec(4)
      else:
        let (_, q, src, dst) = scanTuple(l, "move $i from $i to $i")
        cmds.add((q, src-1, dst-1))
    for s in rawStacks.mitems: s = s.reversedTrim()
    (cmds, rawStacks)

  block Part1:
    var stacks = inputStacks
    for (q, src, dst) in cmds:
      for i in 0..<q:
        stacks[dst].add(stacks[src].pop())
    let p1 = stacks.getTops()
    echo p1 # "ZWHVFWQWW"

  block Part2:
    var stacks = inputStacks
    for (q, src, dst) in cmds:
      stacks[dst].add(stacks[src].lastN(q))
      stacks[src].setLen(stacks[src].len - q)
    let p2 = stacks.getTops()
    echo p2 # "HZFZCCWWV"
