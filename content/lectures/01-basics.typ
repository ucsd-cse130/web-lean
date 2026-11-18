#import "../../config.typ": fig, gap, side-fig, snippet, template, tufted
#show: template.with(title: "Lean Crash Course Part I")

// All Lean code on this page comes from code/Lectures/Basics.lean,
// which is checked by `make check` (lake build).
#let code(name) = snippet("Basics", name)

= Lean Crash Course Part I

== What is Lean?

#side-fig("lean-logo.svg", width: 60%, alt: "Lean 4 logo", invert-dark: true)

A *typed*, *strict*, *purely functional* PL

- functions as values
- types ...


And a *proof assistant*

- *Propositions* to _specify_ properties of your code
- *Proofs* to _verify_ those properties *for all* inputs


#gap

== Functional Programming = Computation by Calculation

_Substituting equals by equals_

```
    (1 + 3) * (4 + 5)
                        -- subst 1 + 3 = 4
==>       4 * (4 + 5)
                        -- subst 4 + 5 = 9
==>       4 * 9
                        -- subst 4 * 9 = 36
==>       36
```

Lean will do the calculation for you

#code("calc")

#gap

== Computation via Substituting Equals by Equals

Enables *Abstraction* via *Pattern Recognition*

#gap

== Abstraction via Pattern Recognition

*Repeated Expressions*

```
                31 * (42 + 56)
                70 * (12 + 95)
                90 * (68 + 12)
```

*Recognize Pattern as a Function*

#code("pat-def")

*Function Call is Pattern Instance*

```
pat 31 42 56 =*> 31 * (42 + 56) =*> 31 * 98  =*> 3038
pat 70 12 95 =*> 70 * (12 + 95) =*> 70 * 107 =*> 7490
pat 90 68 12 =*> 90 * (68 + 12) =*> 90 * 80  =*> 7200
```

*Key:* Computation is _substitute_ equals by equals

#gap

== Functional Programming

_Substitute Equals by Equals_

Thats it!

_Forget_ registers, stacks, frames etc.

#gap

== Elements of Lean

*The Trinity of Expressions, Types, and Values*

#side-fig("trinity.png")

- Core program element is an *expression*
- Every _valid_ expression has a *type*
- Every _valid_ expression reduces to a *value*

*Types are static, Values are dynamic*

- *Types* determined at _compile-time_
- *Values* computed at _run-time_

*_Ill-typed_ expressions are rejected at _compile-time_*

- _Like_ in Java
- _Unlike_ Python or JavaScript

#code("weirdo")

#gap

== Why are types good?

- Helps with program _design_
- Types are _contracts_ (ignore ill-typed inputs!)
- Catches errors _early_
- Allows compiler _to generate code_
- Enables compiler _optimizations_

In Lean, types are _specifications_ (more on this soon!)

#gap

== The Lean Eco-System

- *Compiler:* `lean` checks (and compiles) a file
- *Build Tool:* `lake` builds, manages libs etc.
- *Editor:* VS Code + the Leanextension
- *Online:* #link("https://live.lean-lang.org")[live.lean-lang.org]
  runs Lean in browser

#gap

== Interacting with Lean

Instead of separate shell, ask Lean questions _inside_ file

#code("commands")

`#check e` shows the _type_ of `e`

`#eval e` computes the _value_ of `e`

`#reduce e` shows result after substituting eq-by-eq

#gap

== A Lean Source File

A sequence of *top-level definitions* `x₁`, `x₂`, ...

- Each has _type_ `type₁`, `type₂`, ...
- Each defined by _expression_ `expr₁`, `expr₂`, ...

#code("source-file")

#gap

== Basic Types

#code("basic-types")

#gap

== QUIZ: Natural Numbers

What does this evaluate to?

#code("quiz-nat")

*A.* `-2`

*B.* `0`

*C.* Error!

#gap

== QUIZ: Basic Operations

#code("quiz-if")

What is the _type_ of `quiz`?

*A.* `Int`

*B.* `Bool`

*C.* Error!

#gap

== QUIZ: Basic Operations

#code("quiz-if")

What is the _value_ of `quiz`?

*A.* `9`

*B.* `20`

*C.* Other!

#gap

== Function Types

In Lean, a *function is a value* that has a type

```
A → B
```

A function that

- takes _input_ of type `A`
- returns _output_ of type `B`

Define `fun`-expressions (_anonymous_ functions)

#code("isPos-fun")

But Lean lets us put parameter on the _left_

#code("isPos-def")

Meaning is *identical* to `fun n => ...`

#gap

== The Type Checker is Your Friend

What's wrong here?

#code("isPos-oops")

Lean rejects it with _Unknown identifier_ `x`

... before the code ever runs!

#gap

== Multiple Argument Functions

A function that

- takes three _inputs_ `A1`, `A2` and `A3`
- returns one _output_ `B` has the type

```
A1 → A2 → A3 → B
```

For example

#code("pat-fun-typed")

which we can write with the params on the _left_ as

#code("pat-def")

#gap

== QUIZ

What is the type of `quiz` ?

#code("quiz-fun")

*A.* `Int → Int`

*B.* `Int → Bool`

*C.* `Int → Int → Int`

*D.* `Int → Int → Bool`

*E.* `Int × Int → Bool`

#gap

== Function Calls

A function call is just the function _followed by_ its argument (no
parentheses or commas needed)

```
e1 e2
```

where `e1` is a function and `e2` is the argument, _e.g._

#code("calls")

#gap

== Multiple Argument Calls

With multiple arguments, pass them in one by one

```
(((e e1) e2) e3)
```

For example

#code("calls-multi")

#gap

== Tests: Examples Before Code

Lean lets us write _tests_ right next to the code

#code("tests")

If a test fails, the _file does not compile_.

#gap

== Lets write some Functions

#link("https://www.htdp.org/")[A Recipe]

*Step 1:* Write some _tests_

*Step 2:* Write the _type_

*Step 3:* Write the _code_

*Step 4:* Write some _properties_

*Step 5:* Write the _proof_

#gap

== EXERCISE: `myMax`

Write a function that returns the _maximum_ of two inputs

*1. Tests*

#code("myMax-tests")

*2. Type*

#code("myMax")

*3. Code:* Fill in the `???` above

*4. Properties*

```lean
def myMax (a b : Int) : Int :=
  if a ≥ b then a else b
```


#gap

== EXERCISE: `abs`

Write a function that returns the _absolute value_ of an `Int`

*1. Tests*

#code("abs-tests")

*2. Type & 3. Code*

#code("abs-type")

*4. Specification*

#code("abs-spec")

A `Prop` is a _statement_ ... that may be true or false.

#gap

== Tests vs. Specifications

#code("bool-vs-prop")

A _test_ checks *one* input; a _specification_ talks about *all* inputs

#code("prop-no-eval")

So how can we _check_ a specification? Stay tuned...

#gap

== How to Return Multiple Outputs?

#gap

== Tuples

A type for packing `n` different kinds of values into a single "struct"

```
T1 × ... × Tn
```

For example

#code("tuples")

#gap

== QUIZ

What is the type `???` of `tup3`?

#code("quiz-tup")

*A.* `Nat × Bool`

*B.* `Nat × Float × Bool`

*C.* `Nat × (Float × Bool)`

*D.* `(Nat × Float) × Bool`

*E.* `Tuple × Bool`

#gap

== Tuples Nest to the Right

In Lean, `A × B × C` _means_ `A × (B × C)`

#code("tup-nest")

(So options *B* and *C* in the quiz are the _same_ type!)

#gap

== Extracting Values from Tuples

We can *create* a tuple of three values `e1`, `e2`, and `e3` ...

```
(e1, e2, e3)
```

... but how to *extract* the values from this tuple?

*Pattern Matching* via `match` expressions

#code("tup-match")

or via *projections* `.1` and `.2`

#code("tup-proj")

#gap

== QUIZ

What is the value of `quiz` defined as

#code("quiz-snd3")

*A.* `'a'`

*B.* `5.2`

*C.* `7`

*D.* `('a', 5.2)`

*E.* `(5.2, 7)`

#gap

== EXERCISE: `swap`

*1. Tests*

#code("swap-tests")

*2. Type & 3. Code*

#code("swap")

*4. Specification:* swapping twice gives back what you started with

#code("swap-spec")

#gap

== EXERCISE: `clamp`

*1. Tests*

#code("clamp-tests")

*2. Type & 3. Code*

#code("clamp")

*4. Specification:* the result always lies between `lo` and `hi`

#code("clamp-spec")

#gap

== EXERCISE: `isLeapYear`

*1. Tests:* why is _one_ example not enough?

#code("leap-tests")

*2. Type & 3. Code*

#code("leap")

#gap

== EXERCISE: `quadrant`

*1. Tests:* pick the _boundary_ examples!

#code("quadrant-tests")

*2. Type & 3. Code*

#code("quadrant")

#gap

== Recap

#fig("trinity.png", width: 60%)

- Core program element is an *expression*
- Every _valid_ expression has a *type* (determined at compile-time)
- Every _valid_ expression reduces to a _value_ (computed at run-time)

*Execution*

- Basic values & operators
- Execution / Function Calls just _substitute equals by equals_
- Pack data into _tuples_
- Unpack data via _pattern-matching_

*Specification*

- _Tests_ (`#guard`) check examples
- _Specifications_ (`Prop`) describe _all_ inputs
