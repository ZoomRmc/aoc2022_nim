# aoc2022_nim
AoC 2022 in Nim

## Previous years:
 - [2021](https://github.com/ZoomRmc/aoc2021_nim)
 - [2020](https://github.com/ZoomRmc/aoc2020_nim)

## General notes
What I'm trying to stick to while writing the solutions, in order of importance:
 - Intelligible implementation logic, clear data flow
 - Brevity must not hurt readability
 - Short, self-sustaining functions with evident behaviour, hopefully as "strict" as reasonable
 - Keep the solutions for both parts of the task separated (one should work in case the other was removed from the code), extract repeating computations to functions/templates
 - Use the more suitable data structures available (it's tempting and boring to solve *everything* with Hash Tables)
 - Explore standard library before jumping to external libs

## Notes on specific days
**Spoilers below!**

### Day 10
<details>
<summary>Day 10 spoiler</summary>
Again I opt for separating parsing and executing commands. The fact it's easier to reason about the bugs this way is a bonus.
</details>

### Day 9
<details>
<summary>Day 9 spoiler</summary>
Nothing unusual, this day favours separating primitive routines into their own procedures and writing clean simple logic.
</details>

### Day 8
<details>
<summary>Day 8 spoiler</summary>
Again, no-tricks imperative code with branching, loops in breaks in my initial solution.
</details>

### Day 7
<details>
<summary>Day 7 spoiler</summary>
We could get the total sizes for each folder while parsing, but I opted for building a clean proper filesystem while parsing and walking it for the first part. Not much reason to change it for the second.
</details>

### Day 6
<details>
<summary>Day 6 spoiler</summary>
The day where easy beats smart.
</details>

### Day 5
<details>
<summary>Day 5 spoiler</summary>

Parsing the initial state is the hard part. My initial solution for this is as imperative as it is ugly, but at least it's one pass over the input. Actual execution is a no-brainer.
</details>

### Day 4
<details>
<summary>Day 4 spoiler</summary>

No real twist here, just have to be careful when considering *edge* cases, especially for overlapping.
</details>

### Day 3
<details>
<summary>Here's some words missing from this day's description: </summary>

> the Elves are divided into **distinct non-intersecting** groups of three

I almost thought it's going to be a combinatorial hell! Otherwise, `system:set` make it a breeze.
</details>

### Day 2
<details>
<summary>Day 2 spoiler</summary>
You can spend a lot of time juggling modular ops and end up with an impenetrable and bug-prone code. Just make a neat LUT! Both solutions provided.
</details>

### Day 1
<details>
<summary>Day 1 spoiler</summary>
Using provided `sort`/`sorted` routines is just lazy! Manual branching is absolutely fine, but a generalized routine to keep track of biggest numbers in an array may come handy later.
</details>
