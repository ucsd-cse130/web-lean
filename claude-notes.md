# CSE 130 in Lean: Specs, Testing, Verification — 10-Week Sketch

Oct 7, 2026 · @Ranjit

This mirrors CSE 130's own topic progression — FP basics, datatypes and recursion, higher-order functions, environments/closures/interpreters, type classes/functor/monads, and state machines — rather than being organized around testing concepts, with lexing and parsing dropped to make room. Every week still carries the same three strands: writing a **specification**, **testing** it (via Plausible, or bounded enumeration for relational models), and eventually **proving** it. Hughes' taxonomy of property styles and *How to Design Programs'* examples-before-code discipline run throughout rather than getting their own week; Daniel Jackson's relational modeling and small-scope hypothesis anchor weeks 8-9, and verification is concentrated in weeks 9-10, closing with an interpreter-correctness proof and a generalized protocol-safety proof instead of a separate capstone.

## Week 1 — FP Basics

Core syntax — functions, let, if/then/else, tuples, booleans — with the #eval-driven examples-before-code habit starting on day one, including the first Prop written down before Plausible even exists to check it.

- **`abs : Int → Int`** — examples first (`abs (-3) = 3`); first `Prop` ever written in the course: `abs x ≥ 0`, stated but not yet checked.
- **`swap : α × β → β × α`** — tuples; spec `swap (swap p) = p`, the course's first round-trip property, written down before Plausible exists to test it.
- **`clamp lo hi x : Int`** — nested `if`/`then`/`else`; spec: the result always lies between `lo` and `hi`, the first inequality-style spec.
- **`isLeapYear : Nat → Bool`** — boolean logic with a genuine edge case (divisible by 4 but not 100, unless by 400) — a clean example of why examples-before-code catches bugs a single test wouldn't.
- **`quadrant : Int → Int → Nat`** — nested conditionals on a pair of signs, good practice for picking boundary examples (zero on an axis).

## Week 2 — Datatypes & Recursion

Algebraic data types and recursion introduced together, same as the current course's own pairing — pattern matching on user-defined types, then structural recursion over them, both still under HtDP's examples-first rule.

- **`Shape` ADT and `area`** — `inductive Shape | circle (r : Float) | rect (w h : Float) | triangle (b h : Float)`; pattern matching on a user-defined sum type for the first time, non-recursively.
- **BST `insert` on a hand-rolled `Tree`** — `inductive Tree | leaf | node (l : Tree) (v : Nat) (r : Tree)`; the data definition is written before `insert`, combining "new datatype" and "recursion over it" in one example.
- **`reverse : List α → List α`** — examples first (`reverse [1,2,3] = [3,2,1]`); `reverse (reverse xs) = xs` is stated as a `Prop` but deliberately not yet tested or proved.
- **`maxList : List Nat → Option Nat`** — the `Option` in the signature *is* the contract (empty input has no max); examples include the empty-list edge case.
- **`gcd` via well-founded recursion** — the week's termination speed bump: naive structural recursion doesn't work, so `termination_by`/`decreasing_by` is introduced here; property: `gcd a b ∣ a ∧ gcd a b ∣ b`.

## Week 3 — Higher-Order Functions

map, filter, and fold as the vocabulary for list recursion from here on, with their own small laws (fusion, idempotence, De Morgan-style dualities) as the first taste of "generic" properties that will reappear as type-class laws in weeks 6-7.

- **`List.map` reimplemented** — property: `map f (map g xs) = map (f ∘ g) xs` (map fusion) and `length (map f xs) = length xs`.
- **`List.filter` reimplemented** — property: idempotence `filter p (filter p xs) = filter p xs`, plus the necessary/sufficient membership property.
- **`List.foldr`/`foldl`, used to define `sum` and `length`** — property: `sum xs = foldr (· + ·) 0 xs` and similarly for `length`, introducing fold as "the one recursion scheme behind all the others."
- **`compose : (β → γ) → (α → β) → (α → γ)`** — property: associativity, `(f ∘ g) ∘ h = f ∘ (g ∘ h)`.
- **`List.all`/`List.any` via fold** — metamorphic property: `all p xs = !(any (!p ·) xs)` (De Morgan on lists), a property that needs no oracle.

## Week 4 — Environments & Closures

A small expression language with variables, let, and first-class functions, evaluated against an explicit environment — the unit where shadowing and lexical-vs-dynamic scoping bugs live, so the specs are mostly about getting binding right.

- **A small `Expr` language with variables and `let`, evaluated via an explicit environment** — `eval : Env → Expr → Option Int`; property: shadowing works (`eval [] (Let x 1 (Let x 2 (Var x))) = some 2`), tested with hand-picked shadowing examples — the classic interpreter bug.
- **First-class functions as closures** — `inductive Value | num (n : Int) | closure (param : String) (body : Expr) (env : Env)`; property: a closure captures its *defining* environment, not the caller's — tested with an example that would differ under dynamic scoping.
- **Substitution-based vs. environment-based evaluation** — property: for closed terms, `evalSubst e = evalEnv [] e`, an oracle-based property comparing two implementations of the same semantics.
- **`let rec` and recursive closures** — property: a closure can call itself; test a small recursive function (e.g. factorial) written *in* the toy language and evaluated correctly.

## Week 5 — Interpreters & Semantics

`Deeper interpreter correctness: constant folding in the presence of variables, a compiler to a stack machine, and a small-step evaluator checked against the big-step one — semantics-preservation properties without needing a parser, since lexing/parsing is skipped this round`.

- **`simplify` with variables in scope** — property: `eval env (simplify e) = eval env e` for all `env`, a harder version of earlier constant folding now that variables exist.
- **A stack-machine compiler, `compile : Expr → List Instr`** — property: `run (compile e) env = eval env e`; flagged explicitly as "remember this one" since it's proved in week 10.
- **A small-step evaluator, `step : Config → Option Config`, checked against the big-step `eval`** — property: iterating `step` to completion agrees with `eval` — an oracle-based property connecting two styles of operational semantics.
- **An accumulator-passing (tail-recursive) evaluator vs. the naive one** — metamorphic property: both agree on every output, a natural discussion point for evaluation strategy without needing a parser.

## Week 6 — Type Classes & Functor

T`ype classes and Functor, picked up right where week 3's map left off — the same fusion law, now stated once for any Functor instance instead of once per data type`.

- **`Ord`/`DecidableEq` instances for the week-2 `Tree` and `Shape` types** — class laws as properties: trichotomy and transitivity of `compare`.
- **A `Functor` instance for `Tree`** — laws: `map id t = t` and `map (g ∘ f) t = map g (map f t)` — the same fusion law from week 3's `List.map`, now generalized to any `Functor`.
- **A `Functor` instance over the week 4-5 `Expr`/`Value` types** (e.g. mapping a transformation over all literals in an expression) — more practice writing and testing instances on a less obvious shape.
- **A `Monoid` class with `empty`/`combine`** — laws: identity and associativity, tested across three instances (`List` under `++`, `Nat` under `+`, `String` under concatenation) — the clearest demonstration of "one law, many instances."

## Week 7 — Monads

`Monads, built by refactoring the week 4-5 interpreter itself: the environment-threading evaluator becomes a State monad, error handling becomes Except, and the laws are tested on code students already trust`.

- **The `Option` monad as a "safe pipeline"** (chained lookups/divisions) — monad laws (left identity, right identity, associativity) tested on `Option`.
- **The week 4-5 interpreter rewritten using a `State Env` monad** — same evaluator, same tests, now threading the environment implicitly; monad laws tested on a type students already trust.
- **The interpreter's error handling rewritten with `Except String`** — property: errors propagate and short-circuit correctly, replacing week 4's bare `Option`.
- **A small nondeterminism monad (`List` as "all possible results")** — laws tested on a type further from `Option`/`State`, to show the laws aren't specific to one shape.

## Week 8 — Relational Modeling & the Small-Scope Hypothesis

The relational-modeling methodology — signatures as finite sets, facts as decidable predicates, bounded checking in place of proof — taught directly in Lean with Fintype/Finset/Decidable and decide, so nothing new to install: Jackson's small-scope hypothesis is something students watch happen in the same tool they've used all quarter.

- **Address book with aliases** (Jackson's own running example) — `AddressBook := Finset (Name × Name)` over a `Fintype Name` of size ≤4; "every alias resolves" is a `Decidable` predicate, checked by `decide` over every address book up to that scope.
- **A two-process mutual-exclusion protocol** — states and transitions as a `Fintype`-bounded relation; `MutualExclusion` checked by `decide` over every reachable state found by bounded enumeration — the model this proof gets built on in week 9.
- **A key-card access-control system** — same approach: `Finset`-valued relation, `Decidable` fact ("every granted access traces to a valid card"), checked by `decide` — the model week 10 generalizes to a full proof.
- **A vending-machine or traffic-light state machine** — a classic small FSM; `decide`-checked reachability and a safety invariant (never both lights green), good practice before the two models that carry forward.

## Week 9 — From Bounded Checking to Induction

With the methodology in hand, the week turns from checking to proving: two warm-up structural inductions on week 2's data, then the mutual-exclusion model's safety invariant lifted from "checked up to this bound" to "true for every reachable state" — scaffolded, with the invariant statement given, since stating the right invariant is usually the hard part.

- **`reverse (reverse xs) = xs`** (week 2) — warm-up structural induction, reconnecting to data-structural induction before the state-machine proof.
- **The BST invariant is preserved by `insert`** (week 2) — a second warm-up, structural induction on `Tree`.
- **The mutual-exclusion invariant, proved for real** — the week 8 bounded check becomes an inductive-invariant proof over arbitrarily many transitions; scaffolded, with the invariant statement given so the work is the case-by-case inductive step, not finding the invariant from scratch.

## Week 10 — Verified Interpreters & Protocols

Two closing proofs, each one a property tested or checked earlier in the quarter made unbounded: interpreter/compiler correctness from week 5, and a second protocol's safety property generalized from week 8's bounded check — deliberately just two, not a proof marathon.

- **Compiler correctness**: `∀ e env, run (compile e) env = eval env e` (week 5, tested; now proved by induction on `Expr`).
- **The access-control invariant from week 8, generalized** — the bounded `decide`-based check becomes an inductive-invariant proof, this time with less scaffolding than week 9's since it's the same pattern on a second system.

## Notes on grading, cuts, and risks

**This revision**: dropped Alloy/Forge as a tool — the relational-modeling methodology (signatures as finite sets, facts as decidable predicates, bounded checking, the small-scope hypothesis) is now taught directly in Lean via Fintype/Decidable/decide, so students never leave the one tool. The instructor supplies the Plausible generators for weeks 4-5 rather than having students write them. Week 10's closing proofs are cut from four to two (compiler correctness and one generalized protocol invariant), and the week 9 state-machine proof is scaffolded with the invariant given rather than open-ended.

- **Grading student specs**: run them against a bank of deliberately buggy mutant implementations (seeded from Hughes-style bug variants and from the bounded counterexamples weeks 8-9 produce) — a spec is good if it rejects every mutant and accepts the reference.
- **What's cut or shrunk**: laziness drops out entirely; Prolog isn't actually on the WI26 schedule despite the course overview mentioning it, so nothing lost there; lexing and parsing is cut in favor of two extra weeks for environments/closures/interpreters and state machines/protocols, per the mirrored CSE130 structure; Alloy/Forge is cut too — the methodology is taught directly in Lean instead, so there's no second tool; and week 10's proof load is cut from four proofs to two.
- **Open risks**: Lean's mandatory termination can derail week 2 if not scaffolded (fuel or `partial` as an escape hatch); Plausible's custom-generator story is less mature than QuickCheck's, so weeks 4`-5 (the Expr/Value/environment types) need instructor-written Arbitrary instances rather than relying on deriving; environments and closures are two full weeks now, and scoping/shadowing bugs are subtle even without the proof side, so those weeks need strong reference-semantics test suites before any proof is expected`; analog exams need proof-reading and spec-writing questions rather than proof-writing ones, since LLMs are strong at producing Lean proofs; the old OCaml/Haskell exam bank stops being a useful sample-exam resource and needs a replacement.
