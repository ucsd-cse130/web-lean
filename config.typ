#import "@preview/tufted:0.1.1"

// Header links: `href: title` for a plain link, or `title: (href: title, ...)`
// for a dropdown menu.
#let header-links = (
  "/": "Home",
  "/lectures/": "Lectures",
  "/assignments/": "Assignments",
  "/policies/": "Policies",
  "Links": (
    "https://piazza.com/class/mk1dsic8wex19w": "Piazza",
    "https://canvas.ucsd.edu": "Canvas",
  ),
)

#let make-header(links) = html.header(html.nav(
  for (key, val) in links {
    if type(val) == dictionary {
      html.elem("span", attrs: (class: "dropdown"), {
        html.elem("span", attrs: (class: "dropdown-toggle", tabindex: "0", role: "button"), key + " ▾")
        html.elem("span", attrs: (class: "dropdown-menu"), {
          for (href, title) in val { html.a(href: href, title) }
        })
      })
    } else {
      html.a(href: key, val)
    }
  },
))

// Same as `tufted.tufted-web`, but with a header that supports dropdowns.
#let site(
  title: "CSE 130: Programming Languages",
  lang: "en",
  css: (
    "https://cdnjs.cloudflare.com/ajax/libs/tufte-css/1.8.0/tufte.min.css",
    "/assets/tufted.css",
    "/assets/custom.css",
  ),
  content,
) = {
  show: tufted.template-math
  show: tufted.template-refs
  show: tufted.template-notes
  show: tufted.template-figures
  set text(lang: lang)

  html.html(lang: lang, {
    html.head({
      html.meta(charset: "utf-8")
      html.meta(name: "viewport", content: "width=device-width, initial-scale=1")
      html.title(title)
      for css-link in css { html.link(rel: "stylesheet", href: css-link) }
    })
    html.body({
      make-header(header-links)
      html.article(html.section(content))
    })
  })
}

#let template = site

// Centered image from assets/img/, e.g. #fig("dijkstra.jpg", width: 60%).
// `width` is relative to the text column (Tufte CSS: 55% of the section).
#let fig(file, width: 60%, alt: "") = {
  let w = calc.round(width / 1% * 0.55, digits: 2)
  let m = calc.round((55 - w) / 2, digits: 2)
  html.elem("img", attrs: (
    src: "/assets/img/" + file,
    alt: alt,
    class: "lecture-img",
    style: "width: " + str(w) + "%; margin-left: " + str(m) + "%;",
  ))
}

// Image in the right margin (Tufte margin figure), e.g. #side-fig("dijkstra.jpg").
// Place it just before the paragraph it should sit beside.
// `width` is relative to the margin column, e.g. #side-fig("x.png", width: 50%).
// `invert-dark: true` flips dark-on-transparent images (e.g. logos) in dark mode.
#let side-fig(file, width: 100%, alt: "", caption: none, invert-dark: false) = tufted.margin-note({
  html.elem("img", attrs: (
    src: "/assets/img/" + file,
    alt: alt,
    class: if invert-dark { "margin-img invert-dark" } else { "margin-img" },
    style: "width: " + repr(width) + ";",
  ))
  if caption != none { caption }
})

// A named snippet from code/Lectures/<file>.lean, delimited in the Lean source by
//   -- ANCHOR: name
//   ...
//   -- ANCHOR_END: name
// Hidden answers written as /-?-/answer/-?-/ are shown as `???`.
// Fails the build (rather than showing wrong code) if the anchors are missing,
// duplicated or out of order. Usage: #snippet("Basics", "isPos-def")
#let snippet(file, name, lang: "lean") = {
  let path = "/code/Lectures/" + file + ".lean"
  let lines = read(path).split("\n")
  let begin = "-- ANCHOR: " + name
  let end = "-- ANCHOR_END: " + name
  let where-is(marker) = lines.enumerate().filter(((i, l)) => l.trim() == marker).map(((i, l)) => i)
  let (starts, ends) = (where-is(begin), where-is(end))
  let ctx = "snippet \"" + name + "\" in " + path + ": "
  assert(starts.len() == 1, message: ctx + "expected one `" + begin + "`, found " + str(starts.len()))
  assert(ends.len() == 1, message: ctx + "expected one `" + end + "`, found " + str(ends.len()))
  let (s, e) = (starts.first(), ends.first())
  assert(s < e, message: ctx + "`" + end + "` comes before `" + begin + "`")
  let body = lines
    .slice(s + 1, e)
    .filter(l => not l.trim().starts-with("-- ANCHOR"))
    .join("\n")
    .replace(regex("(?s)/-\?-/.*?/-\?-/"), "???")
  raw(body, block: true, lang: lang)
}

// Vertical whitespace between "slides" in lecture notes (was runs of <br>)
#let gap = html.elem("div", attrs: (class: "slide-gap"))

// Lecture notes and static files (PDFs, code) still live on the old site.
#let old-site = "https://ucsd-cse130.github.io/wi26"
#let raw-url(file) = old-site + "/static/raw/" + file
#let lecture-url(name) = old-site + "/lectures/" + name + ".html"
#let gh-url(path) = "https://github.com/ucsd-cse130/wi26/blob/main/" + path
