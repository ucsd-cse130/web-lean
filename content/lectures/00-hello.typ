#import "../../config.typ": fig, gap, side-fig, template, tufted
#show: template.with(title: "Hello, world!")

= Hello, world!

== A Programming Language

=== Two Variables

- `x`, `y`

=== Three Operations

- `x++`
- `x--`
- `x = 0 ? L1 : L2`

#gap

== Example Program

(What _does_ it do?)

```
L1: x++
    y--
    y = 0 ? L2 : L1
L2: ...
```

#gap

== The above language is "equivalent to" every PL!

But good luck writing

- ... QuickSort
- ... Fortnite
- ... Spotify!

#gap

== So Why Study Programming Languages?

#gap
#gap

== Edsger Dijkstra "On the foolishness of natural language programming", 1978

#side-fig("dijkstra.jpg", width: 85%, alt: "Edsger Dijkstra")

"From one gut feeling I derive much consolation: I suspect that machines to
be programmed in our native tongues --- be it Dutch, English, American,
French, German, or Swahili --- are as damned difficult to make as they would
be to use." -- Edsger Dijkstra

#gap


== Fifty years later ...

#side-fig("elephant-in-room.webp", width: 70%, alt: "the elephant in the room")

`ChatGPT`, `Claude`, `Gemini`, `Grok`, *vibe code* all software!

#gap

== Greg Brockman, President, CTO & Co-Founder, OpenAI

#fig("brockman-rust.png", width: 90%)

#gap

== Not just OpenAI...

#fig("rust-android.png", width: 90%)

... similar stories from Microsoft, Meta, Amazon, etc.

#gap

== How to ensure _"if it compiles, it is \~correct"_?

#side-fig("dijkstra.jpg", width: 70%, alt: "Edsger Dijkstra")

#quote(block: true)[
  The virtue of formal texts is that their manipulations, in order to be
  legitimate, *need to satisfy only a few simple rules;* they are, when you
  come to think of it, an amazingly effective tool for ruling out all sorts of
  nonsense that, when we use our native tongues, are almost impossible to
  avoid.
]

#gap

== Goal: Programming Language as a means of Abstraction

How to _specify_

- What a program *does*?
- What a program *does not*?

#gap

== Course Goals

#side-fig("galaxy-brain-130.jpg", width: 85%, alt: "130 Brain")

New languages come (and go ...). There was no

- Java 30 years ago
- C\# 25 years ago
- Rust 15 years ago
- WebAssembly 5 years ago

#gap

== Goal: Learn the Anatomy of PL

#side-fig("anatomy.png", width: 70%, alt: "Anatomy")


- What makes a programming language?

- Which features are *fundamental*?

- Which features *window dressing*?

#gap

== Goal: Learn New Languages / Constructs

#side-fig("music-score.png", width: 70%, alt: "Musical Score")

New ways to *describe* and *organize* computation, to create programs that
are:

- *Correct*
- *Readable*
- *Extendable*
- *Reusable*

#gap

== Goal: How to Design new Languages

New languages being designed as we speak

#side-fig("fortnite-verse.png")

- `React` \@ Facebook
- `Rust` \@ Mozilla
- `TypeScript` \@ Microsoft
- `Swift` \@ Apple
- `WebAssembly` \@ Google, Mozilla, MS
- `Verse` \@ Epic Games

#gap

== Goal: How to Design new Languages

Every large system has a domain-specific language

- Databases: `SQL`
- Word, Excel: `Formulas`, `Macros`, `VBScript`
- Emacs: `LISP`
- Build: `shell scripts`, `Makefiles`, ...

Work on large system $=>$ Will design a PL!

#gap

// == Goal: Enable You To Choose Right PL
// But isn't that decided by
// - Libraries
// - Standards
// - Hiring
// - Your Boss?!
// Yes.
// *My goal:* Educate tomorrow's leaders so you'll make *informed* choices.
// #gap

== The Crew

=== Profs

#link("https://ranjitjhala.github.io/")[Ranjit Jhala]

- Professor at CSE since 2005
- Research: Tools and Techniques to make programs better

#gap

== The Crew

=== Teaching Assistants

- #link("mailto:ckurashige@ucsd.edu")[Cole Kurashige]

=== Tutors

- #link("mailto:yux070@ucsd.edu")[Yuehua Xie]
- #link("mailto:atz001@ucsd.edu")[Alain Zhang]

#gap

== Course Syllabus

*Functional Programming*

- Lambda calculus (2 weeks)
- Functional Programming (4 weeks)
- Building an Interpreter (3 weeks)

*Logic Programming*

- Prolog (\~1 week, maybe, but doubtful!)

#gap

== *QuickSort* in C

```c
void sort(int arr[], int beg, int end){
  if (end > beg + 1){
    int piv = arr[beg];
    int l = beg + 1;
    int r = end;
    while (l != r-1)
       if(arr[l] <= piv) l++;
       else swap(&arr[l], &arr[r--]);
    if(arr[l]<=piv && arr[r]<=piv)
       l=r+1;
    else if(arr[l]<=piv && arr[r]>piv)
       {l++; r--;}
    else if (arr[l]>piv && arr[r]<=piv)
       swap(&arr[l++], &arr[r--]);
    else r=l-1;
    swap(&arr[r--], &arr[beg]);
    sort(arr, beg, r);
    sort(arr, l, end);
  }
}
```

#gap

== *QuickSort* in Lean

```lean
def sort (l: List Int) : List Int :=
  match l with
  | []      => []
  | x :: xs =>
    let ls := xs.filter (· ≤ x)
    let rs := xs.filter (x < ·)
    sort ls ++ [x] ++ sort rs

  termination_by l => l.length
  decreasing_by all_goals (simp; grind [List.length_filter_le])
```

(*Note:* not a wholly
#link("http://stackoverflow.com/questions/7717691/why-is-the-minimalist-example-haskell-quicksort-not-a-true-quicksort")[fair comparison...])

#gap

== Course Logistics

#link("https://ucsd-cse130.github.io/wi26")[webpage]

- Calendar
- Lecture notes
- Programming assignments

#link("https://piazza.com/class/mk1dsic8wex19w")[piazza]

- Go-to for any questions or help

#gap

== Policies

- No podcasting
- No screens (phones, laptops) in lecture
- Attendance & class participation (sheets)
- Exams must be taken on given date & place

#gap

== Grading

- 10% Class participation (_worksheets_)
- 30% Programming Assignments (_codespaces_)
- 30% Two Midterm *Tu 1/27* and *Thu 2/19* (_in lecture_)
- 30% Final *Tu 3/18*
- 05% Piazza Extra Credit (_top 5_ best participants)

#gap

== Class participation (10%)

- "In class" worksheets handed out each lecture
- Handed in at the end of the lecture
- Turn in 75% of worksheets to get full credit
- Responses only graded on participation

#gap

== Assignments (30%)

*6 programming assignments*

- Released #link("/assignments/")[online]
- At least a week before due date
- Via github classroom + codespaces

*Six late days*

- used as *whole unit*
- 5 mins late = 1 late day
- at most 4 per assignment

*No Groups*

- Assignments must be submitted individually via github
- Ok to discuss with classmates, but solution must be your own

#gap

== Exams (15 + 15 + 30%)

- Must be done at allotted time and location
- 2-sided "cheat sheet"
- The final is cumulative

#gap

/*
== Clickers

Assigned Seating

- From next lecture
- See your group (/static/raw/seating.txt) and seat
  (https://ucsd-cse130.github.io/wi20/static/raw/Center_113_groups.pdf)

Make class interactive

- Help *you* and *me* understand what's tricky

Not Optional

- *Cheap* ones are fine
- *Respond* to 75% questions

#gap

== Clicker Protocol

+ *Solo Vote*
  - Think for yourself, select answer
+ *Discuss*
  - Analyze problem in groups
  - Reach consensus
  - Have questions, raise your hand!
+ *Group Vote*
  - Everyone in group votes
  - Hopefully the same way but not enforced
  - You _don't have to answer correctly_ to get points!
+ *Class Discuss*
  - What was easy or tricky?

#gap
*/

== Your Resources

=== Discussion section

- Th 6:00-6:50pm (CENTER 212)

=== Office hours

- Every day, check *CANVAS calendar*

=== Piazza

- We answer during work hours and office hours (M-F)

=== No text

- Online lecture notes and links

#gap

== Academic Integrity

Programming assignments: do not copy from classmates or from previous years

Exams done *alone*

- Zero Tolerance
- Offenders punished ruthlessly
- Please see academic integrity statement

#gap

== Students with Disabilites

Students requesting accommodations for this course due to a disability or
current functional limitation must provide a current *Authorization for
Accommodation (AFA)* letter issued by the Office for Students with
Disabilities (OSD) which is located in University Center 202 behind Center
Hall.

Students are required to present their AFA letters to Faculty (please make
arrangements to contact me privately) and to the CSE OSD Liaison
#link("https://cse.ucsd.edu/people/administrative-staff/christina-rontell")[Christina Rontell]
in advance so that accommodations may be arranged.

#gap
