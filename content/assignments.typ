#import "index.typ": template, tufted, raw-url
#show: template.with(title: "Assignments")

#let hwid = "https://forms.gle/ZS5WYcreHKFZjT8Z7"
#let hw0 = "https://classroom.github.com/a/fVADzDND"
// #let hw1 = "https://classroom.github.com/a/0ek-gbnL"
// #let hw2 = "https://classroom.github.com/a/hw9LUEuc"
// #let hw3 = "https://classroom.github.com/a/vtmNbvNf"
// #let hw4 = "https://classroom.github.com/a/xeUtlYau"
// #let hw5 = "https://classroom.github.com/a/NFd-YU8c"

#let exam(file, name) = link(raw-url(file), name)

= Assignments

== Late Policy

You have a total of _six late days_ that you can use throughout the quarter,
but no more than _four late days_ per assignment.

- A late day means anything between 1 second and 23 hours 59 minutes and 59
  seconds past a deadline
- If you submit past the late day limit, you get 0 points for that assignment
- There is no penalty for submitting late but within the limit

== Accessing the assignments

Copied from #link("https://piazza.com/class/mk1dsic8wex19w/post/25"), these
are instructions for both accessing the assignments and working on HW0 in the
unlikely case that you do not have access.

At least four students so far have reported problems with accessing their
repository (although two of them seem to have resolved it on their own).

Before you take this option, please make sure you are logged into your GitHub
account and click this link (note: this is for HW0 ONLY) #link(hw0) to access
the assignment. If that does not work, do two things first.

+ Check your email for an invitation from GitHub to join your repository. You
  MUST accept that in order to do the assignment.
+ Try from an incognito window and separate browser (I have been told Firefox
  has some issues with codespaces).

If this still does not work, please make a private piazza post with the link
to your repository on GitHub classroom and your GitHub handle. If you have one
already, please update that post. Then, follow the instructions below to work
on the HW. These instructions only apply for HW0. For future homeworks, we
expect you to have access to the repositories.

+ Navigate to #link("https://github.com/ucsd-cse230/00-lambda"). This is a
  public repository.
+ Skip to the instructions in the readme that describe the problems
  (#link("https://github.com/ucsd-cse230/00-lambda/tree/master?tab=readme-ov-file#problem-1-01_boollc")[starting with Problem 1]).
+ Navigate to the associated file in `tests/`
+ Copy the entire contents of the file into
  #link("https://elsa.goto.ucsd.edu/index.html")[Elsa].
+ Now you can work on the PA in Elsa.
+ To save your work, copy the contents in Elsa to another file (I recommend
  putting it in your Google Drive); the extension does not matter so long as
  it is plaintext.
+ Once your repository is set up, you can copy the contents you saved into
  the corresponding files in `tests/`

== Assignments

Fill in #link(hwid)[this form] by *Fri 1/16* so we can link your github and
UCSD IDs. Otherwise *you will get `0`* for the programming assignments!

#table(
  columns: 3,
  table.header[*HW-link*][*Name*][*Deadline (23:59:59pm)*],
  link(hwid)[HW \#id], [Github ID],       [Fri 1/17],
  link(hw0)[HW \#0],   [Lambda Calculus], [Wed 1/21],
  // link(hw1)[HW \#1], [Intro to Haskell],       [Wed 2/5],
  // link(hw2)[HW \#2], [Data types],             [Fri 2/14],
  // link(hw3)[HW \#3], [Higher-order Functions], [Fri 2/22],
  // link(hw4)[HW \#4], [Interpreters],           [Fri 3/7],
  // link(hw5)[HW \#5], [Classes],                [Fri 3/21],
)

== Sample Exam Questions

Note: 2018 exams are the most representative. Older exams use OCaml instead
of Haskell. Check out these
#link("https://ucsd-cse130.github.io/web/lectures/02-haskell.html")[lecture notes]
for a comparison between the two languages.

- #exam("130-midterm-sp18.pdf")[Midterm Sp 18]
  (#exam("130-midterm-sp18-solution.pdf")[solution])
- #exam("midterm-sp15.pdf")[Midterm Sp 15], ocaml code ported to
  #exam("MidtermSp15.hs")[haskell]
- #exam("midterm-sp14.pdf")[Midterm Sp 14], ocaml code ported to
  #exam("MidtermSp14.hs")[haskell]
- #exam("midterm-sp12.pdf")[Midterm Sp 12],
  #exam("midterm-wi12.pdf")[Midterm Wi 12].
- #exam("130-final-sp18.pdf")[Final Sp 18]
  (#exam("130-final-sp18-solution.pdf")[solution]),
  #exam("final-sp14.pdf")[Final Sp 14],
  #exam("final-fa12.pdf")[Final Fa 12],
  #exam("final-sp12.pdf")[Final Sp 12],
  #exam("final-fa11.pdf")[Final Fa 11],
  #exam("final-wi11.pdf")[Final Wi 11].
