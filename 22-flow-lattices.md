---
numbersections: true
fontsize: 11pt
geometry:
- hmargin=1.25in
- vmargin=1in
header-includes: |
	\usepackage{amsmath}
    \usepackage[charter]{mathdesign}
    \usepackage{inconsolata,stmaryrd,eucal}
    \usepackage[scale=0.96]{sourcesanspro}
    \usepackage[font={footnotesize,sf},labelfont=bf]{caption}
    \setcounter{section}{21}
---

# Distributive Flow Lattices$^\varnothing$

***Status: Unwritten***

## Pseudoflows and Circulations

Let $\Sigma$ be a planar map.  A _pseudoflow_ in $\Sigma$ is an antisymmetric function $\phi\colon D(\Sigma)\to \mathbb{R}$ from the darts of $\Sigma$ to the reals; here antisymmetry means $\phi(d) = -\phi(\textsf{rev}(d))$ for every dart $d$.[^form] Pseudoflows in $\Sigma$ define a real vector space $C_1(\Sigma)$, unimaginatively called the _chain space_ of $\Sigma$, whose dimension is equal to the number of _edges_ of $\Sigma$.  If we arbitrarily fix a _reference dart_ $e^+$ for every edge $e$, then we can specify a unique 1-chain by assigning arbitrary values to the reference darts.

[^form]: In the lecture on the Maxwell-Cremona correspondence, we used exactly the same definition for _discrete 1-forms_ or _1-cochains_, but topologists should really think of pseudoflows as _1-chains_.

A _circulation_ is a pseudoflow that obeys _Kirchhoff’s current law_: For every vertex $v$, the values assigned to darts into $v$ sum to zero.  (We previously called circulations _closed discrete 1-forms_)  More generally, the _boundary_ $\partial\phi$ of any pseudoflow is the function $\partial\phi\colon V(\Sigma)\to\mathbb{R}$ defined by $$\partial\phi(v) = \sum_{u\mathord\to v} \phi(u\mathord\to v) = \sum_{d\colon \textsf{head}(d)=v} \phi(v).$$  (At the risk of confusing the reader, I will use the first summation notation even when $\Sigma$ has parallel edges.)

Fix a tree-cotree decomposition $(T,C)$ of $\Sigma$.  For any non-tree edge $e\in C$, the _fundamental cycle_ $\textsf{cycle}_T(e^+)$ is the directed cycle consisting of the reference dart $e^+$ and the directed path in $T$ from $\textsf{head}(e^+)$ to $\textsf{tail}(e^+)$.

**Lemma:** _Fix an arbitrary planar map $\Sigma$ and an arbitrary tree-cotree decomposition $(T, C)$ of $\Sigma$.  Every circulation $\phi$ in $\Sigma$ satisfies the identity $$ \phi = \sum_{e\in C} \phi(e^+) \cdot \textsf{cycle}_T(e^+) $$._

## Aptly Named Sir Not

