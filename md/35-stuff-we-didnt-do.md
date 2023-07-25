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
    \setcounter{section}{25}
---

# Closing the Loop$^\varnothing$

We covered several topics related to _planar_ curves and maps early in the course, which we did not revisit in the context of more complex surfaces.  For some topics, I decided not to cover the surface generalization because the results are considerably more technical.  For others, I didn’t cover the surface generalization because little or nothing is known.  In this final chapter, I’ll walk through each of the early planar topics and describe the state of the art for the surface generalization.

## Simple Polygons

As we’ve already seen, the Jordan curve theorem does not generalize to surfaces with positive genus.  Indeed, the _definition_ of the genus of a surface $\mathcal{S}$ is the maximum number of disjoint simple closed curves in $\mathcal{S}$ whose complement is connected.  Nevertheless, some of our most basic results on simple polygons do generalize to “polygons” on more complex surfaces.

To properly generalize _polygons_ in the plane to more complex surfaces, we need an appropriate generalization of _line segments_, which in turn relies on appropriate generalizations of _lengths_ and _angles_.

**Theorem:**
_Any geodesic embedding of a graph on any surface with constant Gaussian curvature can be extended to a  geodesic triangulation without adding vertices._

## Winding Numbers

These are only well-defined for null-homologous curves; these are sometimes called _lacets_.  For non-orientable surfaces, winding numbers are only defined modulo $2$; for orientable surfaces, they can be defined either as integers or a residues with respect to any integer modulus.

## Curve Homotopy

Homotopy moves; Dehn’s algorithm

## Shortest Homotopic Paths and Cycles

Algorithms for traversal/crossing curves with respect to any edge-weighted surface map.  Given a walk $W$ with hop-length $k$ in a surface map with complexity $n$ and genus $g$, we can find the minimum-length walk homotopic to $W$ (with fixed endpoints) in $O(gnk)$ time.  if $W$ is a closed walk, we can find the shortest closed walk homotopic to $W$ in $O(gnk \log nk)$ time.

Shortest homotopic systems of loops, pants decompositions, graph embeddings

## Gauss codes

Unsigned Gauss codes are well-defined for any (multi)curve on any surface; signed Gauss codes require the underlying surface to be orientable.

A signed Gauss code of length $n$ can be interpreted as a rotation system for a $4$-regular graph with $n$ vertices, and thus represents a unique curve (up to homeomorphism) on a unique orientable surface.

In principle, given an unsigned Gauss code $x$ and a surface $\mathcal{S}$ (specified by orientability and genus), we can determine whether $x$ is consistent with a curve on $\mathcal{S}$ in time $g^{O(g)}n$ as follows.

1. Construct the Nagy graph $G(X)$.

2. Compute any Euler tour of $G(X)$.

3. Construct the Dehn _diagram_ $D(X)$ of this Euler tour (not just the Dehn _code_).

4. Finally, check whether the Dehn diagram $D(X)$ can be embedded on $\mathcal{S}$.  This, of course, is the hard part.

## Curve Invariants and Simplification

## Geodesic Embeddings

### Inductive {-}
### Tutte {-}
### Koebe {-}
### Schnyder {-}

## Maxwell--Cremona

### Non-planar Frameworks in the Plane {-}

Let $\Sigma$ be an orientable surface map---that is, a graph $G$ together with a rotation system $\textsf{succ}$---with positive genus.  (The underlying graph $G$ might be planar!)  Any position function $p\colon V(\Sigma) \to \mathbb{R}^2$ induces a straight-line drawing of $G$ in the plane.  I will call the pair $(G,p)$ a _framework_ and (for lack of better standard terminology) the pair $(\Sigma, p)$ an _ordered framework_.  The _displacement_ of any dart $u{\to}v$ in $G$ with respect to $p$ is the vector $\Delta(u{\to}v) = p(v)-p(u)$.  The dual graph $G^*$ is the underlying graph of the dual surface map $\Sigma^*$.

The definitions of non-zero, strict, and equilibrium stresses and closed and exact 1-forms all generalize directly from the setting where $\Sigma$ is a planar map.

However, closed discrete 1-forms on positive-genus maps are not necessarily exact.  Consider, for example, the 1-form defined on a toroidal grid, where all “upward” darts have value $1$, and all “horizontal” darts have value $0$; this discrete 1-form is closed but not exact.

The difference between closed and exact 1-forms is captured by _cohomology_ on the surface map $\Sigma$.  Closed 1-forms are duals of circulations; exact 1-forms are duals of boundary circulations; thus, two closed 1-forms are cohomologous if and only if their difference is an exact 1-form.

Not every equilibrium stress on a framework induces a reciprocal framework.  First, the definition of “reciprocal” requires a rotation system to define the dual graph $G^*$; only _ordered_ frameworks have reciprocals.  But even with a fixed rotation system, the dual displacement function $\Delta^*(d^*) := \omega(d)\cdot\Delta(d)^\bot$ is not necessarily an exact 1-form on the dual graph $G^*$ (although it is always closed).  I will call a stress $\omega$ _reciprocal_ for an ordered framework $(\Sigma,p)$ if the dual displacement function $\Delta^*$ is a closed 1-form on $G^*$.

**Theorem:**
_An equilibrium stress $\omega$ for an ordered framework $(\Sigma,p)$ induces a reciprocal framework $(\Sigma^*, p^*)$ if and only if $\omega$ is a reciprocal stress for $(\Sigma,p)$.  Conversely, any reciprocal framework $(\Sigma^*,p^*)$ defines a unique reciprocal stress $\omega$ for $(\Sigma, p)$._

Notice that this theorem describes restrictions on both the stress $\omega$ and the rotation system defining $\Sigma$.  The same stress $\omega$ can be reciprocal for some rotation systems but not others.

### Polyhedral Lifts of Non-planar Frameworks {-}

What about the correspondence between reciprocal diagrams and polyhedral lifts?



### Toroidal Frameworks {-}



## References







