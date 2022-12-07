from std/strutils import parseInt, isDigit, split

const
  INPUTF = "input/aoc07.txt"
  SPACE = 70000000
  GOAL = 30000000
  SMALL = 100000

type
  Node = ref NodeObj
  NodeObj = object
    leaves: seq[Node]
    name: string
    fsize: int

proc walk(n: Node; smallTotal: var int): int =
  if n.leaves.len > 0:
    for l in n.leaves:
      n.fsize.inc l.walk(smallTotal)
  if n.fsize <= SMALL:
    smallTotal.inc n.fsize
  n.fsize

func newNode(name: string): Node {.noinit.} =
  result = new(Node)
  result.name = name

proc minReq(n: Node; need: int): int =
  result = n.fsize
  for l in n.leaves:
    let newmin = l.minReq(need)
    if newmin < result and newmin >= need: result = newmin

proc main*() =
  var fs = block:
    var stack: seq[Node] = @[new(Node)]
    for line in lines(INPUTF):
      if line[0] == '$':
        if line[2] == 'c':
          var dname = line.substr(5, line.high)
          if dname == "..":
            dname = stack.pop().name
          else:
            let n = newNode(dname)
            stack[^1].leaves.add n
            stack.add n
        else: continue
      else:
        if line[0].isDigit:
          let size = block:
            var s=0
            for x in line.split():
              s = parseInt(x)
              break
            s
          stack[^1].fsize.inc size
    stack[0]

  var p1 = 0
  fs.fsize = fs.walk(p1)
  echo p1 # 1501149

  let need = GOAL - (SPACE - fs.fsize)
  let p2 = fs.minReq(need)
  echo p2 # 10096985

when isMainModule:
  main()
