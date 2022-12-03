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
