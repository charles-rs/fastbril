+++
title = "Bril bytecode interpreter"
[extra]
bio = """
	Charles Sherk is an junior studying Computer Science & Mathematics at
	Cornell university, interested in compilers and programming language
	implementation.
"""
[[extra.authors]]
name = "Charles Sherk"
link = "https://github.com/charles-rs/"
+++

## Motivation
Currently we have access to `brili`, which is written with an emphasis on
readable code and extensiblity, and `brili-rs`, which is supposed to be faster,
but `brili-rs` isn't actually that fast, and seems to be rather bloated for what
it is. There were some points in this course where time was spent on "waiting
for the Bril interpreter" that could have been avoided. So, we propose and
implement an interpreter for Bril whose sole focus is speed.

## Design overview

### Language choice
We chose C for an implementation language as it is known for its speed as well
as simplicity, which means we won't inadvertently write code that is more
expensive than necessary.

### Big Red Bytecode
In order to make our interpreter as efficient as possible, we have designed a
very compressed representation of bril instructions: (almost) all of them are
represented in 64 bits, with some taking multiple 64 bit words as needed. See
[documentation](https://github.coecis.cornell.edu/cs897/fast-bril/blob/master/doc/brb.pdf)

In order to appease the C typechecker and not rely on undefined behavior, we use
a union type to internally represent instructions, but most have the first 16
bits as the opcode, so we can pull this out and then determine how to decode the
rest of the instruction. In principle, we could also use `uint64_t` or
`uint16_t[4]`, but using unions is the most user friendly, and lets the C
compiler do more work to access the fields of structs, in case there are any
cool tricks for that behind the scenes.

### Features
We support a superset of the behavior provided by `brili`, so options like `-p`
work exactly the same. We also support the following:
 - `-b` will read in bytecode instead of the Bril json
 - `-bo <file>` will output the bytecode to `<file>`
 - `-pr` will print the program to standard out (probably more useful with the
         `-b` option)
 - `-ni` will NOT run the interpreter.
 - `-e <file>` will emit assembly to `<file>`.

### The Assembly situation
We translate temporaries to consecutive natural numbers (the first seen is 0,
then 1, etc.), and we couldn't help but notice that these numbers could easily
be multiplied by 8

Our interpreter consists of an initial pass to translate into this bytecode,
which turns temps and labels from strings into numbers, and reduces the size of
the code overall. The bytecode instructions are stored in an array so that we
can benefit from cache locality. We then interpret them by iterating through
this array. One minor inconvenience is that certain instructions, such as print,
require multiple words, and this means that our array index for iteration will
NOT be an induction variable, so the C compiler will not be able to optimize it
as aggressively. One solution to this could be making a less flat structure, and
using pointers for the multiword instructions, but this seems like more troubles
than it's worth, especially considering the benefits of cache locality.
