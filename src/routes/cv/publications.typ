// Publication list shared by the janosh.dev CV (cv.typ) and tailored CVs kept outside this
// repo, so every CV renders papers.yaml the same way. Callers set the section heading
// and pass joint_first_author: papers.yaml ids where I'm joint first author without being
// listed first (cv.yml).

#let me(author) = author.given == "Janosh" and author.family == "Riebesell"
// every given name as an initial, hyphenated ones kept hyphenated: Shyue Ping → S. P.,
// Chia-Hong → C.-H., Rhys E. A. → R. E. A.
#let initials(author) = {
  let names = author.given.split(" ").filter(name => name != "")
  let initial(name) = name.split("-").map(part => part.first() + ".").join("-")
  names.map(initial).join(" ") + " " + author.family
}
// First, own and last author with … for gaps
#let authors(list) = {
  let my_idx = list.position(me)
  assert(my_idx != none, message: "Janosh Riebesell missing from a publication")
  let last = list.len() - 1
  let shown = if list.len() <= 3 { range(list.len()) } else {
    (0, if my_idx > 0 and my_idx < last { my_idx } else { 1 }, last)
  }
  let parts = ()
  for (pos, idx) in shown.enumerate() {
    if pos > 0 and idx - shown.at(pos - 1) > 1 { parts.push[…] }
    let name = initials(list.at(idx))
    parts.push(if idx == my_idx { strong(name) } else { name })
  }
  parts.join[, ]
}
#let year(paper) = paper.issued.first().year
#let date(paper) = {
  let issued = paper.issued.first()
  issued.year * 10000 + issued.at("month", default: 0) * 100 + issued.at("day", default: 0)
}

#let publications(papers, joint_first_author: ()) = {
  // * first or joint first author, † senior (last) author
  let marker(paper) = if me(paper.author.first()) or paper.id in joint_first_author [\* ] else if me(paper.author.last()) [† ]
  [
    #text(size: 8.8pt)[\* first or joint first author, † senior author]
    #[
      #set text(size: 9.1pt)
      #set enum(spacing: 0.5em)
      #for paper in papers.sorted(key: paper => -date(paper)) {
        // long journal names (over 20 characters) print abbreviated to avoid extra line breaks
        let venue = paper.at("container-title", default: "preprint")
        if venue.len() > 20 { venue = paper.at("container-title-short") }
        let href = if "DOI" in paper { "https://doi.org/" + paper.DOI } else { paper.at("URL", default: none) }
        enum.item[
          // italic title, upright venue: bold would compete with my bolded name in the authors
          #marker(paper)#authors(paper.author). _#paper.title;_. #venue (#year(paper)).
          #if href != none { link(href)[link] }
          // published papers also link the preprint they were posted as (papers.yaml archive)
          #if "archive" in paper [· #link(paper.archive)[preprint]]
        ]
      }
    ]
  ]
}
