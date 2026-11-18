#import "index.typ": template, tufted, raw-url, lecture-url, gh-url
#show: template.with(title: "Lecture Notes")

#let html(name) = link(lecture-url(name))[html]
#let local(name) = link("/lectures/" + name + "/")[html]  // ported lectures
#let pdf(name) = link(raw-url(name + ".pdf"))[pdf]
#let code(path) = link(gh-url(path))[code]
#let src(file) = code("static/code/src/" + file)
#let lc(file) = code("static/raw/" + file)
#let ditto = [\"\"]

= Lecture Notes

The live-edited code for each lecture can be found
#link("https://github.com/ucsd-cse130/wi25/tree/master/static/code/src")[here].

#table(
  columns: 5,
  align: (left, left, left, center, center),
  table.header[*Date*][*Topic*][*Notes*][*Markup*][*Code*],
  [1/6],  [Hello, World!],             local("00-hello"),       [],               [],
  [1/8],  [The Lambda Calculus],       html("01-lambda"),       pdf("01-lambda"),   lc("lec_1_8_2026.lc"),
  [1/13], ditto,                       [],                      [],               lc("lec_1_13_2026.lc"),
  [1/15], ditto,                       [],                      [],               lc("lec_1_15_2026.lc"),
  [1/20], [A crash course in Haskell], local("01-basics"),      pdf("02-haskell"),  src("Lec_1_20_2026.hs"),
  [1/22], ditto,                       local("01-recursion"),   pdf("02-haskell"),  src("Lec_1_20_2026.hs"),
  [1/27], [Midterm I],                 [],                      [],               [],
  [1/29], [Datatypes & Recursion],     html("03-datatypes"),    pdf("03-datatypes"), [],
  [2/3],  ditto,                       [],                      [],               src("Lec_2_3_2026.hs"),
  [2/5],  ditto,                       [],                      [],               src("Lec_2_5_2026.hs"),
  [2/10], [Higher Order Functions],    html("04-hof"),          [],               src("Lec_2_10_2026.hs"),
  [2/12], [Environments & Closures],   html("05-environments"), [],               src("Lec_2_12_2026.hs"),
  [2/19], [Midterm II],                [],                      [],               [],
  [2/24], [Lexing and Parsing],        html("06-parsing"),      [],
          link("https://github.com/ucsd-cse130/wi24/tree/main/static/arith")[code],
  [3/3],  [Type Classes],              html("07-classes"),      [],               src("Lec_3_3_2026.hs"),
  [3/5],  [Functors & Monads],         html("08-monads"),       [],               src("Lec_3_5_2026.hs"),
  [3/10], ditto,                       [],                      [],               src("Lec_3_10_2026.hs"),
  [3/12], [Hello, world! (finally!)],  html("09-io"),           [],               src("hello.hs"),
  [3/19], [Final Exam],                [],                      [],               [],
)

// == Discussions
//
// | Date | Topic                  | Slides
// | 1/10 | Lambda Calculus & Elsa |
// | 1/14 | Lambda Calculus        | raw-url("disc1-lambda_calc.pdf")
// | 2/25 | Nano: Parsing and Eval | raw-url("disc5-parsing.pdf")
// | 3/4  | Type checking tips     | raw-url("disc-pa5tips.pdf")
// | 3/11 | Final Review           | raw-url("final-disc.pdf")
// | 3/17 | Final Review           | old-site + "/discussions/final-review.html"
