---
title: One-Dimensional Computational Topology
author: Jeff Erickson
numbersections: false
fontsize: 11pt
geometry:
- hmargin=1.25in
- vmargin=1in
header-includes: |
    \usepackage[charter]{mathdesign}
    \usepackage{inconsolata,sourcesanspro,stmaryrd,eucal}
    \usepackage[font={footnotesize,sf},labelfont=bf]{caption}
---

# Foreward$^\alpha$ {-}

This book consists of lecture notes from a special-topics class on topological graph algorithms that I have taught several times at the University of Illinois.  These lecture notes (and other course materials) are available under a [Creative Commons Attribution license (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

![CC BY 4.0](Fig/cc-by){ width=15% }

I drafted most of these notes in Fall 2020 and revised them in Spring 2023; a handful of chapters (13, 16, 26, 27, 29, 30) were first drafted in Spring 2023.  Even after a second round of revision, these are all still very rough drafts.  Most of the missing chapters either cover material I did not discussed in class, or cover material from my own research papers.

I’ve _attempted_, with various degrees of success, to write the first draft of each note to exactly cover one 75-minute lecture, to force myself to prioritize the most fundamental results, sometimes at the expense of technical details, prerequisite material (like point-set topology or dynamic-forest data structures), accurate reflection of the state of the art, and historical anecdotes.  Later revisions tend to include more technical details that I don't actually cover in lecture, except to say "You can find more details in the notes."  In practice, I can cover at most 5 pages of material in detail in one lecture (and each semester has only 25 lectures).

Similarly, I am writing these notes in Markdown instead of LaTeX, in part to intentionally focus my time on _writing_ instead of typography, and in part to make the final output more accessible by producing HTML and ePub versions.  As a result, the notes are typographically rather awkward/ugly.  Some day I will figure out how to use Pandoc templates and filters, or better yet, a more modern system like Quarto.  (Real Soon Now, Honest.)  For similar reasons, many notes are embarrassingly short on figures and/or references.

I think I’m about 2/3 of the way to a complete first draft of an actual book.  I’m reasonably happy with the current _set_ of chapters, plus or minus one, but less so about their order, especially in the last third.  If I stick to the current outline, the final book should be just over 400 pages long in its current format (or about 600 pages in a more book-friendly format).  Depending their degree of completion, each chapter titles has one of the following annotations:[^related]

* $\varnothing$: mostly (or completely) unwritten
* $\alpha$: mostly written, but missing significant details, or only used once
* $\beta$: reasonably polished, but possibly missing some minor details
* $\delta$: complete and totally polished (so needs only five more rounds of copy editing)
* Nothing: actually done

[^related]: I would like to include a section describing related state-of-the-art results at the end of each chapter.  These annotations ignore those missing sections.)

Once I have a complete draft of the entire book, I plan to make the source files available on Github to attract bug reports, feature requests, and pull requests.  Stay tuned!

