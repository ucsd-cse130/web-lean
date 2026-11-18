/-
  Lecture: Functional Programming in Lean — Basics (Week 1)

  Snippets shown on the slides are delimited by

      -- ANCHOR: name
      ...
      -- ANCHOR_END: name

  and included in `content/lectures/01-basics.typ` via `#snippet("Basics", "name")`.
  Order in this file does not matter for the slides (e.g. tests can be shown
  before the code even though Lean needs the definition first).

  Quiz and exercise answers are written as `/-?-/answer/-?-/`: Lean checks the
  real answer, and the slide shows `???` in its place.
-/

namespace Basics

/-! ## Calculation -/

-- ANCHOR: calc
#eval (1 + 3) * (4 + 5)      -- 36
-- ANCHOR_END: calc

/-! ## Abstraction via pattern recognition -/

namespace Lam
-- ANCHOR: pat-fun
def pat := fun (x y z : Int) => x * (y + z)
-- ANCHOR_END: pat-fun
end Lam

-- ANCHOR: pat-def
def pat (x y z : Int) : Int := x * (y + z)
-- ANCHOR_END: pat-def

/-! ## Ill-typed expressions are rejected -/

set_option pp.mvars false in
/--
error: Function expected at
  1
but this term has type
  ?_

Note: Expected a function because this term is being applied to the argument
  0
-/
#guard_msgs in
-- ANCHOR: weirdo
def weirdo := 1 0     -- rejected by Lean
-- ANCHOR_END: weirdo

/-! ## Interacting with Lean -/

-- ANCHOR: commands
#check 31 * (42 + 56)        -- Nat
#eval  31 * (42 + 56)        -- 3038
#check pat                   -- pat (x y z : Int) : Int
#reduce pat 31 42 56         -- 3038
-- ANCHOR_END: commands

/-! ## A Lean source file -/

namespace Shape
variable (type₁ type₂ : Type) (expr₁ : type₁) (expr₂ : type₂)
-- ANCHOR: source-file
def x₁ : type₁ := expr₁

def x₂ : type₂ := expr₂
-- ANCHOR_END: source-file
end Shape

/-! ## Basic types -/

-- ANCHOR: basic-types
def ex1 : Int    := 31 * (42 + 56)   -- this is a comment
def ex2 : Float  := 3 * (4.2 + 5.6)  -- arithmetic operators are "overloaded"
def ex3 : Char   := 'a'              -- 'a', 'b', 'c', etc. are `Char` values
def ex4 : Bool   := true             -- true, false are the `Bool` values
def ex5 : String := "cat"
def ex6 : Nat    := 42               -- natural numbers: 0, 1, 2, ...
-- ANCHOR_END: basic-types

/-! ## QUIZ: Nat subtraction -/

-- ANCHOR: quiz-nat
#eval (3 - 5 : Nat)
-- ANCHOR_END: quiz-nat
#guard (3 - 5 : Nat) == 0

/-! ## QUIZ: basic operations -/

namespace QuizIf
-- ANCHOR: quiz-if
def ex6 : Int  := 4 + 5
def ex7 : Int  := 4 * 5
def ex8 : Bool := 5 > 4

def quiz : /-?-/Int/-?-/ := if ex8 then ex6 else ex7
-- ANCHOR_END: quiz-if
#guard quiz == 9
end QuizIf

/-! ## Function types -/

namespace Lam
-- ANCHOR: isPos-fun
def isPos : Int → Bool := fun n => n > 0
-- ANCHOR_END: isPos-fun
end Lam

-- ANCHOR: isPos-def
def isPos (n : Int) : Bool := n > 0
-- ANCHOR_END: isPos-def

namespace Oops
/-- error: Unknown identifier `x` -/
#guard_msgs in
-- ANCHOR: isPos-oops
def isPos (n : Int) : Bool := x > 0
-- ANCHOR_END: isPos-oops
end Oops

/-! ## Multiple argument functions -/

namespace Lam
-- ANCHOR: pat-fun-typed
def pat' : Int → Int → Int → Int := fun x y z => x * (y + z)
-- ANCHOR_END: pat-fun-typed
end Lam

/-! ## QUIZ: function types -/

namespace QuizFun
-- ANCHOR: quiz-fun
def quiz : /-?-/Int → Int → Bool/-?-/ := fun x y => (x + y) > 0
-- ANCHOR_END: quiz-fun
end QuizFun

/-! ## Function calls -/

-- ANCHOR: calls
#eval isPos 12          -- true
#eval isPos (0 - 5)     -- false
-- ANCHOR_END: calls

-- ANCHOR: calls-multi
#eval pat 31 42 56      -- 3038
-- ANCHOR_END: calls-multi

/-! ## Tests: examples before code -/

-- ANCHOR: tests
#guard isPos 12                 -- run the test: fails unless `true`
#guard isPos (0 - 5) == false
#guard pat 31 42 56 == 3038     -- toggle to 3039?
-- ANCHOR_END: tests

/-! ## EXERCISE: myMax -/

-- ANCHOR: myMax
def myMax (x y : Int) : Int := /-?-/if x ≥ y then x else y/-?-/
-- ANCHOR_END: myMax

-- ANCHOR: myMax-tests
#guard myMax 10 20 == 20
#guard myMax 100 5 == 100
-- ANCHOR_END: myMax-tests

/-! ## EXERCISE: abs — the first specification -/

-- ANCHOR: abs-type
def abs (x : Int) : Int := /-?-/if x < 0 then -x else x/-?-/
-- ANCHOR_END: abs-type

-- ANCHOR: abs-tests
#guard abs (-3) == 3
#guard abs 0 == 0
#guard abs 5 == 5
-- ANCHOR_END: abs-tests

-- ANCHOR: abs-spec
def abs_nonneg : Prop := ∀ x : Int, abs x ≥ 0
-- ANCHOR_END: abs-spec

/-! ## Bool vs Prop -/

-- ANCHOR: bool-vs-prop
#check abs 5 ≥ 0                -- abs 5 ≥ 0 : Prop
#eval  abs 5 ≥ 0                -- true    (a *single* case can be decided)
#check ∀ x : Int, abs x ≥ 0     -- a Prop about *infinitely* many cases
-- ANCHOR_END: bool-vs-prop

/-- error: failed to synthesize
  Decidable (∀ (x : Int), abs x ≥ 0)

Hint: Additional diagnostic information may be available using the `set_option diagnostics true` command. -/
#guard_msgs in
-- ANCHOR: prop-no-eval
#eval ∀ x : Int, abs x ≥ 0      -- error: cannot run infinitely many tests!
-- ANCHOR_END: prop-no-eval

/-! ## Tuples -/

-- ANCHOR: tuples
def tup1 : /-?-/Char × Nat/-?-/ := ('a', 5)

def tup2 : Char × Float × Nat := ('a', 5.2, 7)
-- ANCHOR_END: tuples

/-! ## QUIZ: nested tuples -/

-- ANCHOR: quiz-tup
def tup3 : /-?-/(Nat × Float) × Bool/-?-/ := ((7, 5.2), true)
-- ANCHOR_END: quiz-tup

-- ANCHOR: tup-nest
example : (Nat × Float × Bool) = (Nat × (Float × Bool)) := rfl
example : (7, 5.2, true) = (7, (5.2, true)) := rfl
-- ANCHOR_END: tup-nest

/-! ## Extracting values from tuples -/

-- ANCHOR: tup-match
def fst3 (t : α × β × γ) : α :=
  match t with
  | (x1, _, _) => x1

def snd3 (t : α × β × γ) : β :=
  match t with
  | (_, x2, _) => x2

def thd3 (t : α × β × γ) : γ :=
  match t with
  | (_, _, x3) => x3
-- ANCHOR_END: tup-match

-- ANCHOR: tup-proj
#eval tup2.1        -- 'a'
#eval tup2.2        -- (5.2, 7)
#eval tup2.2.1      -- 5.2
-- ANCHOR_END: tup-proj

/-! ## QUIZ: snd3 -/

-- ANCHOR: quiz-snd3
def quiz := snd3 tup2
-- ANCHOR_END: quiz-snd3
#guard quiz == 5.2

/-! ## EXERCISE: swap — a round-trip property -/

-- ANCHOR: swap
def swap (p : α × β) : β × α := /-?-/(p.2, p.1)/-?-/
-- ANCHOR_END: swap

-- ANCHOR: swap-tests
#guard swap (1, "one") == ("one", 1)
#guard swap ('a', true) == (true, 'a')
-- ANCHOR_END: swap-tests

-- ANCHOR: swap-spec
def swap_swap : Prop := ∀ (p : Nat × String), swap (swap p) = p
-- ANCHOR_END: swap-spec

/-! ## EXERCISE: clamp — nested if -/

-- ANCHOR: clamp
def clamp (lo hi x : Int) : Int :=
  /-?-/if x < lo then lo else if x > hi then hi else x/-?-/
-- ANCHOR_END: clamp

-- ANCHOR: clamp-tests
#guard clamp 0 10 (-5) == 0
#guard clamp 0 10 5    == 5
#guard clamp 0 10 15   == 10
-- ANCHOR_END: clamp-tests

-- ANCHOR: clamp-spec
def clamp_between : Prop :=
  ∀ lo hi x : Int, lo ≤ hi → lo ≤ clamp lo hi x ∧ clamp lo hi x ≤ hi
-- ANCHOR_END: clamp-spec

/-! ## EXERCISE: isLeapYear — why one example is not enough -/

-- ANCHOR: leap
def isLeapYear (y : Nat) : Bool :=
  /-?-/y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)/-?-/
-- ANCHOR_END: leap

-- ANCHOR: leap-tests
#guard isLeapYear 2024 == true     -- divisible by 4
#guard isLeapYear 2023 == false    -- not divisible by 4
#guard isLeapYear 1900 == false    -- divisible by 100 ...
#guard isLeapYear 2000 == true     -- ... unless divisible by 400
-- ANCHOR_END: leap-tests

/-! ## EXERCISE: quadrant — boundary examples -/

-- ANCHOR: quadrant
def quadrant (x y : Int) : Nat :=
  /-?-/if x == 0 || y == 0 then 0
  else if x > 0 then (if y > 0 then 1 else 4)
  else (if y > 0 then 2 else 3)/-?-/
-- ANCHOR_END: quadrant

-- ANCHOR: quadrant-tests
#guard quadrant 3 4      == 1
#guard quadrant (-3) 4   == 2
#guard quadrant (-3) (-4) == 3
#guard quadrant 3 (-4)   == 4
#guard quadrant 0 4      == 0      -- on an axis
#guard quadrant 3 0      == 0      -- on an axis
-- ANCHOR_END: quadrant-tests

end Basics
