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
    \def\thesection{20a}
---


# Systems of Cycles and Homology$^\alpha$

_Homology_ is a natural equivalence relation between cycles, similar to but both simpler and coarser than homotopy; where homotopy treats cycles as _sequences_ of darts, homology treats cycles as _sets of edges_ (or more generally, _linear combinations_ of darts).  Homology can be defined with respect to any “coefficient ring”, but to keep the presentation simple, I’ll describe only the simplest special case ($\mathbb{Z}_2$-homology) in this section, and return to a slightly more complicated special case ($\mathbb{R}$-homology) in a later note.


## Cycles and Boundaries

Fix a surface map $\Sigma = (V,E,F)$ with Euler genus $\bar{g}$.

$\mathbb{Z}_2$-homology is an equivalence relation between certain  _subgraphs_ of $\Sigma$, formally represented as subsets of $E$.

An _even subgraph_ of $\Sigma$ is a subgraph $H$ such that $\deg_H(v)$ is even for every vertex $v\in V(\Sigma)$.  The empty subgraph is an even subgraph, as is every simple cycle.  Every even subgraph is the union (or symmetric difference) of simple edge-disjoint cycles.

For every edge $e\not\in T$, let $\textsf{cycle}_T(e)$ denote the unique simple undirected cycle in the graph $T+e$; we call $\textsf{cycle}_T(e)$ a _fundamental cycle_ with respect to $T$.  Let $\mathcal{C} = \{ \textsf{cycle}_T(e) \mid e\in L \}$.  The set $\mathcal{C}$ is called a _system of cycles_ for the map $\Sigma$.

**Fundamental Cycle Lemma:**
_Let $T$ be an arbitrary spanning tree of an arbitrary graph $G$ (sic).  For every even subgraph $H$ of $G$, we have $$H = \bigoplus_{e\in H\setminus T} \textsf{cycle}_T(e).$$  Thus, even subgraphs are symmetric differences of fundamental cycles._

**Proof:**
: Let $H$ be an arbitrary even subgraph of $G$, and let $H’ = \bigoplus_{e\in H\setminus T} \textsf{cycle}_T(e)$.  The symmetric difference of any two even subgraphs is even, so $H\oplus H’$ is an even subgraph and therefore the union of edge-disjoint cycles.  On the other hand, $H\oplus H’$ is a subgraph of $T$ and therefore acyclic.  We conclude that $H\oplus H’$ is empty, or equivalently, $H = H’$.  $\qquad\square$

Mnemonically, any even subgraph can be _named_ by listing its edges in $C\cup L$.

Let $Z$ be a subset of the faces of $\Sigma$.  The _boundary_ of $Z$, denoted $\partial Z$, is the subgraph of $\Sigma$ containing every edge that is incident to both a face in $Z$ and a face in $F\setminus Z$.  A _boundary subgraph_ is any subgraph that is the boundary of a subset of faces.  Every boundary subgraph is an even subgraph.  Conversely, if $\Sigma$ is a planar map, the Jordan curve theorem implies that every even subgraph is a boundary subgraph, but this equivalence does not extend to more complex surfaces.

**Fundamental Boundary Lemma:**
_Let $(T,L,C)$ be an arbitrary tree-cotree decomposition of a surface map $\Sigma$.  For every boundary subgraph $B$ of $\Sigma$, we have $$B = \bigoplus_{e\in B\cap C} \textsf{bdry}_C(e).$$   Thus, boundary subgraphs are symmetric differences of fundamental boundaries._

**Proof:**
: We mirror the proof of the Fundamental Cycle lemma.  Let $B$ be any boundary subgraph, and let $B’ = \bigoplus_{e\in B\cap C} \textsf{bdry}_C(e)$.  The boundary space is closed under symmetric difference, so $B’\oplus B$ is a boundary subgraph.  On the other hand, $B\oplus B’$ has no edges in $C$, so $B\oplus B’$ is a subgraph of the cut graph $T\cup L$. We conclude that $B\oplus B’$ is empty, or equivalently, $B = B’$. $\qquad\square$.

Mnemonically, any boundary subgraph can be _named_ by listing its edges in $C$.

## Homology 

Finally, two subgraphs $A$ and $B$ of $\Sigma$ are _($\mathbb{Z}_2$)-homologous_ if their symmetric difference $A\oplus B$ is a boundary subgraph of $\Sigma$.  For example, every boundary subgraph is homologous with the empty subgraph, which is why boundary subgraphs are also called _null-homologous_ subgraphs.  Straightforward definition-chasing implies that ($\mathbb{Z}_2$)-homology is an equivalence relation, whose equivalence classes are obviously called _($\mathbb{Z}_2$)-homology classes_.  We usually omit “$\mathbb{Z}_2$” if the type of homology is clear from context.

**Lemma:**
_Let $(T,L,C)$ be an arbitrary tree-cotree decomposition of a surface map $\Sigma$.  The only boundary subgraph of the cut graph $T\cup L$ is the empty graph._

**Proof:**
: Let $H$ be a non-empty cut graph in $\Sigma$; $H$ must be the boundary of a non-empty proper subset $Z$ of the faces in $\Sigma$.  Consider the fundamental domain $\Delta = \Sigma \mathbin{\backslash\!\!\backslash} (T\cup L)$.  Because both $Z$ and its complement are non-empty, some interior edge $e$ of $\Delta$ separates a face in $Z$ from a face not in $Z$.  But the interior edges of $\Delta$ are precisely the edges in $C$.
$\qquad\square$


**Lemma:**
_Let $(T,L,C)$ be an arbitrary tree-cotree decomposition of a surface map $\Sigma$.  Every even subgraph in $\Sigma$ is homologous with an even subgraph of the cut graph $T\cup L$._

**Proof:**
: It suffices to prove that every edge $e\in C$ is homologous with a subgraph of $T\cup L$ that has even degree everywhere except the endpoints of $e$.

: Consider the fundamental domain $\Delta = \Sigma \mathbin{\backslash\!\!\backslash} (T\cup L)$.  Every edge $e \in C$ appears in $\Delta$ as a boundary-to-boundary chord, which partitions the faces of $\Delta$ into two disjoint subsets $Y\sqcup Z$.  (Recall that no edge in $C$ can be an isthmus!)  Every face of $\Delta$ is a face of the original map $\Sigma$ and vice versa; let $\beta$ denote the boundary of $Y$ (or equivalently, the boundary of $Z$) in $\Sigma$.  Because $\beta$ is a boundary subgraph in $\Sigma$, $e$ is homologous with $\beta\oplus e$.  Finally, every edge in $\beta \oplus e$ is an edge in the cut graph $T\cup L$.  $\qquad\square$

**Lemma:**
_Let $(T,L,C)$ be an arbitrary tree-cotree decomposition of a surface map $\Sigma$.  Every  subgraph of $\Sigma$ is homologous with a symmetric difference of cycles in $\mathcal{C}$._

**Proof:**
: By the previous lemma, it suffices to consider only even subgraphs of the cur graph $T\cup L$.  Every even subgraph of $T\cup L$ is the symmetric difference of simple cycles in $T\cup L$.  The simple cycles in $T\cup L$ are precisely the cycles in $\mathcal{C}$.  $\qquad\square$

**Homology Basis Theorem:**
_Let $(T,L,C)$ be an arbitrary tree-cotree decomposition of a surface map $\Sigma$.  For every even subgraph $H$ of $\Sigma$, we have 
$$
	H =
	\left(\bigoplus_{i\in \smash{I(H)}} \textsf{cycle}_T(\ell_i)\right)
		\oplus
	\left(\bigoplus_{e\in H\cap C} \textsf{bdry}_T(e)\right)
$$
for some subset $I(H) \subseteq \{1,2,\dots,\bar{g}\}$.  Thus, every even subgraph is homologous with the symmetric difference of a **unique** subset of cycles in $\mathcal{C}$, which is nonempty if and only if $H$ is a boundary subgraph._

The Homology Basis Theorem immediately implies an algorithm to decide if two even subgraphs $H$ and $H’$ are homologous: Compute their canonical decompositions into fundamental cycles and boundaries, with respect to the same tree-cotree decomposition, and then compare the index sets $I(H)$ and $I’(H)$.  A careful implementation of this algorithm runs in $O(\bar{g} n)$ time; details are left as an exercise (because we’re about to describe simpler algorithms).

## Relax, it’s just linear algebra!

Unlike our earlier characterization of homotopy, our characterization of homology is unique; every even subgraph is homologous with the symmetric difference of _exactly one_ subset of cycles in $\mathcal{C}$.  The easiest way to prove this fact is to observe that subgraphs, even subgraphs, boundary subgraphs, and homology classes all define vector spaces over the finite field $\mathbb{Z}_2 = (\{0,1\}, \oplus, \cdot)$.  In particular, homology can be viewed as a linear map between vector spaces.

Subgraphs (subsets of $E$) comprise the ***edge space*** (or _first chain space_) $C_1(\Sigma) = \mathbb{Z}_2^{|E|}$.  The (indicator vectors of) individual edges in $\Sigma$ comprise a basis of the edge space.

Even subgraphs of $\Sigma$ comprise a subspace of $C_1(\Sigma)$ called the ***cycle space*** $Z_1(\Sigma)$.  The Fundamental Cycle Lemma implies that the fundamental cycles $\textsf{cycle}_T(e)$, for all $e\not\in T$, define a basis for the cycle space.  The number of fundamental cycles is equal to the number of edges not in $T$, which is $|E|-(|V|-1)$.  Thus, $Z_1(\Sigma) = \mathbb{Z}_2^{|E| - |V| + 1}$.

Boundary subgraphs of $\Sigma$ comprise a subspace of $Z_1(\Sigma)$ called the ***boundary space*** $B_1(\Sigma)$.  The Fundamental Boundary lemma implies that the fundamental boundaries $\textsf{bdry}_C(e)$, for all $e\in C$, define a basis for the boundary space.  The number of fundamental boundaries is equal to the number of edges of $C$, which is $|F|-1$.  Thus, $B_1(\Sigma) = \mathbb{Z}_2^{|F| - 1}$.

Finally, the set of homology classes of even subgraphs of $\Sigma$ comprise the ***(first) homology space***, which is the quotient space
$$
	\begin{aligned}
	H_1(\Sigma)
	&~:=~ Z_1(\Sigma) / B_1(\Sigma) \\
	&~=~ \mathbb{Z}_2^{|E| - |V| + 1} \big/ \mathbb{Z}_2^{|F| - 1} \\
	&~\cong~ \mathbb{Z}_2^{|E| - (|V|-1) - (|F|-1)} \\
	&~=~ \mathbb{Z}_2^{|E| - |T| - |C|} 
	~=~ \mathbb{Z}_2^{|L|} 
	~=~ \mathbb{Z}_2^{\bar{g}}.
	\end{aligned}
$$
(Hey look, we proved Euler’s formula again!)  The Homology Basis Theorem implies that homology classes of fundamental cycles $\textsf{cycle}_T(e)$, for all $e\in L$, define a basis for the homology space.  In particular, there are exactly $2^{\bar{g}}$ distinct homology classes.

## Crossing Numbers

Another way to characterize the homology class of an even subgraph $H$ is to determine which cycles in a system of cycles _cross_ $H$.  The definition of “cross” is rather subtle, but mirrors the intuition of transverse intersection.

Consider two distinct simple cycles $\alpha$ and $\beta$, and let $\pi$ be one of the components of the intersection $\alpha\cap\beta$.  (Because $\alpha\ne\beta$, the intersection $\pi$ must be either a single vertex of a common subpath.)  We call $\pi$ a _crossing_ between $\alpha$ and $\beta$ (or we say that $\alpha$ and $\beta$ _cross_ at $\pi$) if, after contracting the path $\pi$ to a point $p$, the contracted curves $\alpha / \pi$ and $\beta / \pi$ intersect transversely at $p$.

Equivalently, $\alpha$ and $\beta$ cross at $\pi$ if, no matter how we perturb the two curves within a small neighborhood of $\pi$, the two perturbed curves $\tilde\alpha$ and $\tilde\beta$ intersect.  By convention, no two-sided cycle crosses itself (because we can perturb two copies of a two-sided cycle so that they are disjoint), but every one-sided cycle crosses itself once (because we cannot).

For any simple cycles $\alpha$ and $\beta$, the _crossing number_ $\mathsf{cr}(\alpha,\beta)$ is the number of crossings between $\alpha$ and $\beta$, modulo 2.  In particular, $\textsf{cr}(\alpha, \alpha) = 0$ if for every two-sided cycle $\alpha$, and $\textsf{cr}(\beta, \beta) = 1$ for every one-sided cycle $\beta$.

We can extend this definition of crossing number to even subgraphs by linearity: $\textsf{cr}(\alpha\oplus\beta, \gamma) = \textsf{cr}(\alpha,\gamma) \oplus \textsf{cr}(\beta,\gamma)$.  Although one can express any even subgraph as a symmetric difference of cycles in many different ways, crossing numbers are the same for every such decomposition.

For any face $f$ and any cycle $\gamma$, we have $\textsf{cr}(\partial f, \gamma) = 0$.  It follows by linearity that if either $\gamma$ or $\delta$ is a boundary subgraph, then $\textsf{cr}(\delta,\gamma) = 0$.  More generally, it follows that crossing numbers are a _homology invariant_: if $\alpha$ and $\beta$ are homologous even subgraphs, then $\textsf{cr}(\alpha, \gamma) = \textsf{cr}(\beta, \gamma)$ for every cycle $\gamma$, because $\alpha\oplus\beta$ is the symmetric difference of face boundaries.

**Lemma:**
_For any even subgraphs $H$ and $H’$, if $\textsf{cr}(H,H’) = 1$, then neither $H$ nor $H’$ is a boundary subgraph._

**Proof:**
: If (say) $H$ is a boundary subgraph, then $H$ is the symmetric difference of face boundaries, and therefore $\textsf{cr}(H, H’) = 0$ by linearity.  $\qquad\square$

**Lemma:**
_Let $\sigma$ be a simple cycle and let $\mathcal{C} = \{ \gamma_1, \gamma_2, \dots, \gamma_{\bar{g}} \}$ be a system of cycles in a surface map $\Sigma$.  Then $\sigma$ is boundary cycle if and only if $\mathsf{cr}(\sigma, \gamma_i) = 0$ for every cycle $\gamma_i\in \mathcal{C}$._

**Proof:**
: If $\sigma$ is a boundary cycle, homology invariance immediately implies $\textsf{cr}(\sigma, \gamma_i) = \textsf{cr}(\varnothing, \gamma_i) = 0$.

: Suppose on the other hand that $\sigma$ is not a boundary cycle.  Then by definition the sliced surface $\Sigma \mathbin{\backslash\!\!\backslash} \sigma$ is connected.  Let $v$ be a vertex of $\sigma$, and let $\pi$ be any path from $v^+$ to $v^-$ in $\Sigma \mathbin{\backslash\!\!\backslash} \sigma$.  This path $\pi$ appears in $\Sigma$ as a closed walk that crosses $\sigma$ exactly once, so $\textsf{cr}(\pi,\sigma) = 1$.  It follows from the previous lemma that $\pi$ is not a boundary cycle.  Thus, by the Homology Basis theorem, $\pi$ is homologous with $\bigoplus_{i\in I} \gamma_i$ for some non-empty subset $I \subseteq \{ 1,2,\dots,\bar{g} \}$.  Finally, homology invariance implies $\textsf{cr}(\pi, \sigma) = \bigoplus_{i\in I} \textsf{cr}(\gamma_i, \sigma) = 1$, so we must have $\textsf{cr}(\gamma_i, \sigma) = 1$ for an odd number of indices $i\in I$, and therefore for at least one such index. $\qquad\square$

**Corollary:**
_Let $\mathcal{C}$ be a system of cycles in a surface map $\Sigma$.  An even subgraph $H$ of $\Sigma$ is a boundary subgraph if and only if $\mathsf{cr}(H, \gamma_i) = 0$ for every cycle $\gamma_i\in \mathcal{C}$. Two even subgraphs $H$ and $H’$ of $\Sigma$ are homologous if and only if $\mathsf{cr}(H, \gamma_i) = \mathsf{cr}(H’, \gamma_i)$ for every cycle $\gamma_i\in \mathcal{C}$._



## Systems of Cocycles and Cohomology

Cohomology is the dual of homology.  While homology is an equivalence relation between subgraphs of maps, cohomology is an equivalence relation between subgraphs of _dual_ maps.  In fact, it’s the _dual_ equivalence relation between subgraphs of dual maps.  Two subgraphs $A$ and $B$ of $\Sigma$ are _cohomologous_ if and only if the corresponding dual subgraphs $A^*$ and $B^*$ of $\Sigma^*$ are homologous.

I’ll adopt the convenient convention of adding the prefix “co” to indicate the dual of a structure in the dual map.  Mnemonically, a cosnarfle in $\Sigma$ is the dual of snarfle in $\Sigma^*$.

- We’ve already defined a _spanning co-tree_ of $\Sigma$ is a subset of edges whose corresponding dual edges comprise a spanning tree of $\Sigma^*$.  Less formally, a spanning cotree of $\Sigma$ is the dual of a spanning tree of $\Sigma^*$.
- A _cocycle_ in $\Sigma$ is the dual of a cycle in $\Sigma^*$.  (In planar graphs, every cocycle is a minimal edge cut, but that equivalence does not extend to more complex surfaces.)
- A _co-even subgraph_ of $\Sigma$ is the dual of an even subgraph of $\Sigma^*$.  That is, a subgraph $H$ of $\Sigma$ is co-even if every face of $\Sigma$ has an even number of incidences with $H$.  No edge in a co-even subgraph is a loop, because loops are co-isthmuses.
- The _coboundary_ if a subset $X$ of vertices of $\Sigma$, denoted $\delta X$, is the dual of the boundary of the corresponding subset $X^*$ of faces of $\Sigma^*$ .  That is, $\delta X$ is the subset of edges with one endpoint in $X$ and one endpoint not in $X$.  A _coboundary_ subgraph is the coboundary of some subset of vertices.  Every coboundary subgraph is co-even.
- Finally, two co-even subgraphs are cohomologous if their symmetric difference is a coboundary subgraph.

As usual, fix a tree-cotree decomposition $(T,L,C)$ of a surface map $\Sigma$.  For every edge $e\in T\cup L$, let $\textsf{cocycle}_C(e)$ denote the subgraph of $\Sigma$ dual to the fundamental cycle $\textsf{cycle}_{c^*}(e^*)$ in the dual map $\Sigma^*$.  Finally, let $\mathcal{K} = \{ \textsf{cocycle}_C(e) \mid e\in T \}$.  The following lemmas follow immediately from our earlier characterization of homology.

**Lemma:**
_Let $(T,L,C)$ be an arbitrary tree-cotree decomposition of a surface map $\Sigma$.  Every co-even subgraph of $\Sigma$ a symmetric difference of fundamental cocycles $\textsf{cocycle}_C(e)$ where $e\not\in C$._

**Lemma:**
_Let $(T,L,C)$ be an arbitrary tree-cotree decomposition of a surface map $\Sigma$.  Every co-even subgraph of $\Sigma$ is cohomologous with a co-even subgraph of the cocut graph $C\cup L$._

**Lemma:**
_Let $(T,L,C)$ be an arbitrary tree-cotree decomposition of a surface map $\Sigma$.  Every co-even subgraph of $\Sigma$ is cohomologous with a symmetric difference of cocycles in $\mathcal{K}$._

## Homology Signatures

More importantly, however, cohomology offers us a **CO**nvenient method to efficiently **CO**mpute homology classes of even subgraphs of the primal map $\Sigma$, by assigning a **CO**ordinate system to the first homology space.  Index the leftover edges in $L$ as $\ell_1, \ell_2, \dots, \ell_{\bar{g}}$.[^ell]  For every edge $e$ in $\Sigma$, the _homology signature $[e]$_ is the $\bar{g}$-bit vector indicating which cocycles in $\mathcal{K}$ contain $e$.  Specifically:
$$
	[e]_i = 1 \iff e \in  \textsf{cocycle}_C(\ell_i).
$$
Finally, the homology signature $[H]$ of any subgraph $H$ is the bitwise exclusive-or of the homology signatures of its edges.

[^ell]: Here I’m using $\ell$ as a mnemonic for “leftover edge” instead of “loop”.  We have a lot of other $e$’s flying around, so I don’t want to use $e_i$ to denote the $i$th edge in $L$.

The function $H \mapsto [H]$ is a _linear_ function from the cycle space $Z_1(\Sigma)$ to the vector space $\mathbb{Z}_2^{\bar{g}}$ of homology signatures.  In particular: 

**Linearity Lemma:**
_For any two even subgraphs $H$ and $H’$ of $\Sigma$, we have $[H \oplus H’] = [H]\oplus [H’]$._

**Basis Lemma:**
_For all indices $i$ and $j$, we have $[\textsf{cycle}_T(\ell_i)]_j = 1$ if and only if $i=j$._

**Proof:**
: The only edge in any fundamental $\textsf{cycle}_T(e)$ that is _not_ in $T$ is the determining edge $e$.  Similarly, the only edge in any fundamental $\textsf{cocycle}_C(e)$ that is _not_ in $C$ is the determining edge $e$.  Thus, $\textsf{cycle}_T(ell_i) \cap \textsf{cocycle}_C(\ell_j) = \varnothing$ whenever $i\ne j$, and $\textsf{cycle}_T(\ell_i) \cap \textsf{cocycle}_C(\ell_i) = \ell_i$ for every index $i$. $\qquad\square$

**Theorem:**
_Two even subgraphs $H$ and $H’$ of $\Sigma$ are homologous if and only if $[H] = [H’]$._

**Proof:**
: By the Linearity Lemma, it suffices to prove that an even subgraph $H$ is a boundary subgraph if and only if $[H] = 0$.

: Let $f$ be any face of $\Sigma$, and let $\lambda$ be any cocycle in $\Sigma$.  The boundary of $f$ either contains no edges of $\lambda$ or exactly two edges of $\lambda$, depending on whether the dual cycle $\lambda^*$ contains the dual vertex $f^*$. It follows that $[\partial f] = 0$ for every face $f$.  The Linearity Lemma implies that $[H] = 0$ for every boundary subgraph $H$.

: Conversely, suppose $H$ is not null-homologous.  Then we can write
$$
	H =
	\left(\bigoplus_{i\in I} \textsf{cycle}_T(\ell_i)\right)
		\oplus
	\left(\bigoplus_{e\in H\cap C} \textsf{bdry}_T(e)\right)
$$
for some nonempty subset $I\subseteq\{1, 2, \dots, \bar{g}\}$.  The Linearity and Basis lemmas imply that
$$
	[H]
	=
	\left(\bigoplus_{i\in I} [\textsf{cycle}_T(\ell_i)]\right)
$$
and therefore $[H]_i = 1$ if and only if $i\in I$.  Because $I$ is non-empty, $[H]\ne 0$.
$\qquad\square$


## Separating Cycles

**Lemma:** 
_Let $\gamma$ be a simple cycle in a surface map $\Sigma$.  The sliced map $\Sigma \mathbin{\backslash\!\!\backslash} \gamma$ is disconnected if and only if $[\gamma]=0$_

## References

## Aptly Named Sir

* Pants decompositions (except possibly in passing)