# Advent of Code 2020 in Common Lisp

I'm using the Advent of Code 2020 to exercise my Common Lisp muscles.

https://adventofcode/2020

Learnings
----------

Common Lisp is an enormous language with a rich library ecosystem.
It's easy to get stuck in the same old corner of the language you are
familiar with. What I love about the Advent of Code event is the
opportunity to see how other hackers tackle the same small problems.
Here are some of my personal learnings from 2020.

* `labels` is like `flet` but allows for recursion
* Check that a value is within a range thusly: `(<= min value max)`
* `cl-ppcre:register-groups-bind` simplifies text extraction
* `parseq` can be an even nicer text parsing tool
* `alexandria:xor` is Common Lisp's missing xor
* `metabang-bind` can simplify code that requires multiple different kinds of bindings
* `alexandria:map-combinations` and related functions are nice

Anthony Green <green@moxielogic.com>
