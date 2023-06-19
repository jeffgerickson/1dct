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
---

<!-- see “shortest-noncontractible.tex” -->

# Shortest Interesting Cycles$^\alpha$

In this lecture, I’ll describe algorithms to find the shortest cycle in a surface map that is topologically interesting.  I’ll specifically consider two different definitions of “interesting”:

- A cycle is _noncontractible_ if it cannot be continuously deformed to a single point; noncontractible cycles are _homotopically_ nontrivial.
- A cycle is _nonseparating_ if slicing along the cycle does not disconnect the surface; nonseparating cycles are _homologically_ nontrivial.

The input to our algorithms is a surface map $\Sigma$ with positively weighted edges.[^dir]  I will assume throughout this presentation that there is a unique shortest path between any pair of vertices; this assumption can be enforced with standard perturbation schemes.  Crucially, we will treat the underlying graph of $\Sigma$ as a continuous topologically space; any edge with weight $\ell$ is isometric to the interval $[0,\ell]$ on the real line.  Thus, we can reasonably consider shortest paths between points that lie in the interior of edges.

[^dir]: With more effort, these algorithms can be generalized to _directed_ surface maps with asymmetrically weighted _darts_.

## Properties of Shortest Nontrivial Cycles

It is unfortunately common for papers on surface-map algorithms to use the word “cycle” in two different senses.  For topologists, a _cycle_ is the continuous image of the circle $S^1$, but for graph theorists, a _cycle_ is a closed walk with no repeated vertices.  That is, graph theorists assume that cycles are _simple_ (or _injective_), but topologists do not.  Fortunately for us, shortest nontrivial _cycles_ are the same for both tribes.

**Lemma:**
_The shortest noncontractible (or nonseparating) closed walk in a positively edge-weighted surface map is a simple cycle._

**Proof:**
: For the sake of argument, suppose the shortest noncontractible closed walk $W$ is _not_ simple.  We can decompose $W$ into two closed walks $X\cdot Y$ at any vertex that $W$ visits more than once.  $X$ and $Y$ are both shorter than $W$, so they must both be contractible.  The concatenation of two contractible closed walks is contractible.  So $W$ is contractible, contradicting its definition.  Essentially the same argument applies to the shortest nonseparating closed walk. $\qquad\square$

**3-Path Condition (Carsten Thomassen):**
_Let $x$ and $y$ be two points (either at vertices or in edge interiors) in a surface map $\Sigma$, and let $\alpha, \beta, \gamma$ be paths in $\Sigma$ from $x$ to $y$.  If the cycles $\alpha\cdot\textsf{rev}(\beta)$ and $\beta\cdot\textsf{rev}(\gamma)$ are contractible (resp. separating), then the cycle $\alpha\cdot\textsf{rev}(\gamma)$ is also contractible (resp. separating)._

**Proof:**
: The concatenation of any two contractible closed walks is contractible.
: The symmetric difference of any two separating cycles is separating.
$\qquad\square$

**Antipodality Condition (Carsten Thomassen):**
_Let $\sigma$ be the shortest noncontractible (resp. nonseparating) cycle in a surface map $\Sigma$.  Any pair of antipodal points partition $\sigma$ into two equal-length shortest paths._

**Proof:**
: Fix a pair $x$ and $\bar{x}$ of antipodal points in $\sigma$.  These points clearly partition $\sigma$ into two equal-length paths; call these paths $\alpha$ and $\beta$.  Suppose $\alpha$ and $\beta$ are _not_ shortest paths, and let $\gamma$ be a shortest path from $x$ to $\bar{x}$.  The cycles $\alpha\cdot\textsf{rev}(\gamma)$ and $\beta\cdot\textsf{rev}(\gamma)$ are both shorter than $\alpha\cdot\textsf{rev}(\beta) = \sigma$ and thus are contractible (resp. separating).  But then the 3-path property implies that $\sigma$ is contractible (resp. separating), contradicting its definition.  $\qquad\square$

**Crossing Condition:**
_Any shortest path crosses the shortest noncontractible (resp. nonseparating) cycle at most once._

**Proof:**
: Let $\pi$ be a shortest path and let $\sigma$ be a simple noncontractible (resp. separating) cycle, and suppose the intersection $\pi\cap\sigma$ is disconnected.  Then we can decompose $\pi$ into three subpaths $\pi^-\cdot\pi^\circ\cdot\pi^+$, where $\pi^\circ$ starts and ends at vertices of $\sigma$ but is otherwise disjoint from $\sigma$.  Because $\pi$ is a shortest path, its subpath $\pi^circ$ is also a shortest path.  Similarly, we can decompose $\sigma$ into two paths $\alpha$ and $\beta$ at the endpoints of $\pi^\circ$.  The 3-path condition implies that at least one of the cycles $\alpha\cdot\textsf{rev}(\pi^\circ)$ and $\beta\cdot\textsf{rev}(\pi^\circ)$ is noncontractible (resp. nonseparating).  Because vertex-to-vertex shortest paths are unique, both of these cycles are shorter than $\sigma$.   $\qquad\square$

## A polynomial-time algorithm

Thomassen's 3-path condition implies the following algorithm to find the shortest noncontractible cycle $\sigma$.  The antipodality condition implies that $\sigma$ must consist of a shortest path from a vertex $x$ to another vertex $y$, the edge $yz$, and the shortest path from $z$ back to $x$.  (Uniqueness of vertex-to-vertex shortest paths implies that the antipodal point $\bar{x}$ lies in the interior of the edge $yz$.)  There are only $O(n^2)$ loops of this form.  We compute the distance between every pair of vertices in $O(n^2\log n)$ time by running Dijkstra's algorithm $n$ times, after which we can compute the length of each candidate cycle in $O(1)$ time.  Finally, for each candidate loop $\gamma$, we test whether $\gamma$ is contractible in $O(n)$ time, using Dehn’s algorithm.  Finally, we return the shortest candidate cycle that is noncontractible.

**Theorem [Thomassen]:**
_Given any edge-weighted surface map $\Sigma$ with complexity $n$, we can compute the shortest noncontractible cycle in $\Sigma$ in $O(n^3)$ time._

In fact, Dehn’s algorithm is overkill for testing the contractibility of simple cycles.  Instead we can rely on the classical lemma:

**Lemma [David Epstein[^de]]:**
_A nontrivial simple cycle $\sigma$ on any surface $\mathcal{S}$ is contractible if and only if $\mathcal{S}\setminus \sigma$ is disconnected and at least one component is an open disk._

[^de]: David Epstein-with-one-p is a curly-haired English mathematician who was born in  South Africa.  David Eppstein-with-two-p’s is a curly-haired American mathematician (and computer scientist) who was born in England.  It’s a minor miracle that they have never been coauthors.

We can test whether a simple cycle $\sigma$ is the boundary of a disk as follows.  First, we perform a whatever-first search in the dual map $\Sigma^*$ to determine whether the sliced map $\Sigma \mathbin{\backslash\!\!\backslash} \sigma$ (or alternatively, the contracted map $\Sigma / \sigma$) is connected.  If $\Sigma \mathbin{\backslash\!\!\backslash} \sigma$ is connected, then $\sigma$ is noncontractible.  Otherwise, we compute the Euler characteristics and orientability of both components in $O(n)$ time.  If either component is orientable with genus $1$, that component is a disk and $\sigma$ is contractible; otherwise, $\sigma$ is non-contractible.

We can find the shortest _nonseparating_ cycle in the same time bound, using a slightly _simpler_ algorithm.  A given simple cycle $\sigma$ is non-separating if and only if $\Sigma \mathbin{\backslash\!\!\backslash} \sigma$ is connected; we can test this condition in $O(n)$ time using whatever-first search in the dual map $\Sigma^*$.  Otherwise, the algorithm is the same.

**Theorem [Thomassen]:**
_Given any edge-weighted surface map $\Sigma$ with complexity $n$, we can compute the shortest nonseparating cycle in $\Sigma$ in $O(n^3)$ time._

## Near-quadratic time

* Build a tree-cotree decomposition $(T,L,C)$ where $T$ is a shortest-path tree, in $O(n\log n)$ time, using Dijkstra’s algorithm.  

* Let $X^*$ be the _dual_ cut graph $(C\cup L)^*$.  A fundamental loop $\textsf{loop}(x,yz)$ is separating if and only if $(yz)^*$ is a bridge of $X^*$, and contractible if and only if at least one component of $X^*\setminus (yz)^*$ is a tree.

* We can classify every edge of $X^*$ as hair, bridge, or neither in $O(n)$ time.  So we can find shortest noncontractible and nonseparating loops based at $x$ in $O(n\log n)$ time.

* Try all basepoints $\implies O(n^2\log n)$ time.

The high-level approach of this algorithm is due to Sariel Har-Peled and me, but we used a much more complicated algorithm to find shortest interesting loops, which interleaves Dijkstra steps and brute-force traversal of the dual map.  Replacing Dijkstra’s algorithm with a linear-time shortest-path algorithm reduces the overall running time to $O(n^2)$.


This is the fastest algorithm known for arbitrary genus.  However, Martin Kutz proved that for any _constant_ genus $g$, it is possible to computer shortest nontrivial cycles in only $O(n\log n)$ time, by a reduction to the planar minimum-cut problem (or more properly, to the dual problem of finding the shortest generating cycle in an annulus).  The running time of Kutz’s algorithm depends exponentially on the genus.  Later work by Sergio Cabello and Erin Chambers reduced the dependence on $g$ to a small polynomial.


## Multiple-Source Shortest Paths

We can significantly improve Thomassen’s algorithm using a generalization of either of the multiple-source shortest path algorithms that we saw earlier for planar maps.

***[The rest of this section is only an outline.]***

### Parametric {-}

Grove decomposition of the dual cut graph $T\cup L$ into $O(g)$ trees, each with a central cut path.  Each pivot requires $O(g)$ dynamic-forest operations, and thus takes $O(g\log n)$ amortised time.  Each dart pivots into the shortest path tree $T$ at most $O(g)$ times.  Total time is $O(g^2 n\log n)$, assuming generic edge weights.  This can be improved to $O(gn\log n)$ time with more careful data structures and analysis.

![Pivoting one edge into a grove decomposition.](Fig/grove-link-cut){ width=75% }

**Surface-Tree Lemma:**
: _Let $T$ be any tree embedded on a surface with exactly one boundary cycle $B$; call any vertex in $T\cap B$ a boundary vertex.  Let $e$ be any edge of $T$, and let $U$ and $W$ be the components of $T\setminus e$.  Either $U$ contains every boundary vertex, or boundary vertices in $U$ induce at most $g+1$ paths in $B$._ 

**Proof(?):**
: Let $\Sigma$ be the surface map induced by $T \cup B$, and let $o$ be the face of $\Sigma$ bounded by $B$.  Let $(T,L,C)$ be any tree-cotree decomposition of $\Sigma$ with the given spanning tree $T$.

: Consider the subgraph $X^* = C^*\cup L^* \cup \{e^*\}$ of the dual map $\Sigma^*$.  The induced embedding of $X^*$ has exactly two faces, each containing (the faces of $\Sigma^*$ dual to vertices of) one component of $T \setminus e$.  Let $Y^*$ be the boundary subgraph comprised of the non-isthmus edges of $X^*$.  This boundary subgraph can be decomposed into at most $g+1$ simple non-crossing cycles.  (Recall the the _definition_ of the genus $G$ is the maximum number of disjoint cycles whose deletion does not disconnect the surface.)  Each of these cycles crosses $B$ at most twice.  Thus, either $X^*$ does not cross $B$ at all, or $X^*$ splits $B$ into at most $2g+2$ intervals, which alternate between vertices of $U$ and vertices of $W$.  $\qquad\square$


### Recursive {-}

Precompute homology annotations (via a system of cocycles) once at the start.  Compute shortest-path trees $T_i$ and $T_j$ in $O(n\log n)$ time.  Compute homology signatures of all shortest paths from $s_i$ and $s_k$ in $O(gn)$ time.  Dart ${u{\to}v}$ is properly shared by $T_i$ and $T_k$ if it satisfies the following conditions:

- $\textsf{pred}_i(v) = \textsf{pred}_k(v) = u$
- $[\textsf{path}_i(u)] = [\textsf{path}_k(u)]$ --- **This condition is new!** 
- If $t = \textsf{pred}_i(u) = \textsf{pred}_k(u)$, then $t{\to}u$ is properly shared by $T_i$ and $T_k$.
- Otherwise, darts $\textsf{pred}_i(u){\to}u$ and $v{\to}u$ and $\textsf{pred}_k(u){\to}u$ are oriented clockwise around $u$.

The second condition holds if and only if these two shortest paths define a separating arc from $s_i$ through $u$ to $s_k$.

Finding and contracting all properly shared darts takes $O(gn)$ time.  Each vertex has $O(g\deg(v))$ interesting sources, so the total size of all maps at each level of recursion is $O(gn)$.  The total preprocessing time is $O(gn\log n + g^2 n)$; the query time is still $O(\log n)$.  It’s unclear whether $O(gn\log n)$ time can be achieved with this approach.

## Shortest Nonseparating Cycles in Near-Linear Time

**Lemma [Cabello Mohar]:**
_The shortest nonseparating cycle in any surface map $\Sigma$ crosses at least one cycle in a greedy system of cycles for $\Sigma$ exactly once._

**Proof:** 
: ***[[[to be written.  The usual exchange argument implies 3 crossings is impossible, and every nonseparating cycle crosses some basis cycle an odd number of times]]]***

**Lemma:**
_For any cycle $\gamma$, the shortest cycle that crosses $\gamma$ exactly once can be computed in $O(\bar{g}^2 n\log n)$ time._

**Proof:** 
: Let $\Sigma’ = \Sigma \mathbin{\backslash\!\!\backslash} \gamma$.  If $\gamma$ is two-sided, then $\Sigma’$ has two boundary cycles $\gamma^-$ and $\gamma^+$, each of which is a copy of $\gamma$.  If $\gamma$ is one-sided, then $\Sigma’$ has a single boundary cycle $\gamma^\pm$ that covers $\gamma$ twice.  In either case, $\Sigma’$ contains two copies $v^-$ and $v^+$ of every vertex $v$ of $\gamma$.

: Now let $\sigma$ be the shortest cycle in $\Sigma$ that crosses $\gamma$ once.  This cycle appears in $\Sigma’$ as a shortest path from $v^-$ to $v^+$ for some vertex $v$ of $\Sigma$.  We can compute all such shortest paths in $O(\bar{g}^2 n\log n)$ time using either MSSP algorithm, using either $\gamma^+$ or $\gamma^\pm$ as the “outer” face.   $\qquad\square$


**Theorem:**
_The shortest nonseparating cycle in a surface map with Euler genus $\bar{g}$ and complexity $n$ can be computed in $O(\bar{g}^3 n\log n)$ time._

**Proof:**
: Let $(T,L,C)$ be a tree-cotree decomposition of $\Sigma$ where $T$ is a shortest-path tree.  Let $Q$ be the reduced cur graph obtained by removing degree-1 vertices from $T\cup L$, and let $\mathcal{C} = \{\gamma_1, \gamma_2, \dots, \gamma_{\bar{g}} \}$ be the system of cycles induced by $T$ and $L$.

: For each cycle $\gamma_i$, we compute the shortest cycle in $\Sigma$ that crosses $\gamma_i$ exactly once, in $O(\bar{g}n\log n)$ time, by running a multiple-source shortest-path algorithm in $\Sigma \mathbin{\backslash\!\!\backslash} \gamma_i$.  The shortest of these $\bar{g}$ cycles is the shortest nonseparating cycle.  $\qquad\square$

## Shortest Noncontractible Cycles in Near-Linear Time (sketch)

This one is a bit more complicated.

**Lemma:**
_Every noncontractible cycle in any surface map $\Sigma$ crosses any cut graph of $\Sigma$ at least once._

The following lemma distills a more complex argument of Cabello, Chambers, and Erickson.  ***[[[Take this with a grain of salt until I wrote down a complete proof.]]]***

**Lemma:**
_Let $\sigma$ be the shortest noncontractible cycle in some surface map $\Sigma$.  Let $(T,L,C)$ be a tree-cotree decomposition of $\Sigma$ where $T$ is a shortest path tree and $C$ is a maximum spanning tree.  Let $\mathcal{C}$ denote the corresponding system of cycles._

(a) _$\sigma$ crosses each cycle in $\mathcal{C}$ at most once._
(b) _$\sigma$ is a nonseparating cycle if and only if $\sigma$ crosses some cycle in $\mathcal{C}$ at least once._
(c) _If $\sigma$ is a separating cycle, then $\sigma$ is also the shortest non-contractible cycle in $\Sigma’ = \Sigma {\backslash\!\!\backslash} \mathcal{C}$._

**Proof:** 
: ***[[[To be written.  Notice that (a) is a stronger claim than the nonseparating crossing lemma!]]]***

**Lemma:**
_Let $\sigma$ be the shortest noncontractible cycle in some surface map $\Sigma’$ with genus $0$ and at least two boundaries.  Let $\pi$ be the shortest path between any two boundaries of $\Sigma’$.  Either (a) $\sigma$ crosses $\pi$ exactly once, or (b) $\sigma$ does not cross $\pi$ and $\sigma$ is the shortest noncontractible cycle in $\Sigma’ {\backslash\!\!\backslash} \pi$._

**Proof:** 
: ***[[[Mostly follows from the Crossing Condition.]]]***

**Theorem:**
_The shortest noncontractible cycle in a surface map with Euler genus $\bar{g}$ and complexity $n$ can be computed in $O(\bar{g}^3 n\log n)$._

**Proof:**
: Let $(T,L,C)$ be a tree-cotree decomposition of $\Sigma$ where $T$ is a shortest-path tree and $C$ is a maximum spanning tree.  Let $\mathcal{C} = \{\gamma_1, \gamma_2, \dots, \gamma_{\bar{g}} \}$ be the system of cycles induced by $T$ and $L$.

: First, for each cycle $\gamma_i$, we compute the shortest cycle in $\Sigma$ that crosses $\gamma_i$ exactly once, in $O(\bar{g}^2 n\log n)$ time, by running a multiple-source shortest-path algorithm in $\Sigma \mathbin{\backslash\!\!\backslash} \gamma_i$.  The shortest of these $\bar{g}$ cycles is the shortest nonseparating cycle.  Thus, if the shortest noncontractible cycle is nonseparating, then the shortest of these $\bar{g}$ cycles is the shortest noncontractible cycle.  Otherwise, we need to compute the shortest noncontractible cycle in the sliced surface $\Sigma’ = \Sigma \mathbin{\backslash\!\!\backslash} \mathcal{C}$.

: The surface $\Sigma’$ has genus 0 and $b$ boundary cycles, for some $1\le b\le \bar{g}$.  If $b=1$, then $\Sigma’$ is a disk, so every cycle in $\Sigma’$ is contractible.  Otherwise, we compute a shortest path $\pi$ between any two boundary cycles, compute the shortest cycle $\sigma^\times$ in $\Sigma’$ that crosses $\pi$ exactly once via multiple-source shortest paths, and recursively search $\Sigma’ \mathbin{\backslash\!\!\backslash} \pi$.  The algorithm halts after computing $b-1$ cycles; the shortest of these is the shortest noncontractible cycle in $\Sigma’$.

: Altogether the algorithm runs multiple-source shortest paths $\bar{g} + b = O(\bar{g})$ times, each on a surface map with complexity $O(n)$ and genus less than $\bar{g}$.  So the overall running time is $O(\bar{g}^3 n\log n)$, as claimed.
$\qquad\square$


<!--

## Making Shortest Paths Unique

1. Randomized weight perturbation (with high probability)
2. Lexicographic perturbation ($\times O(\log n)$)
3. holiest perturbation ($\times O(g)$)

## Shortest System of Loops

$\Lambda = \Sigma / T \ C$, where $T$ is shortest-path tree from basepoint and $C$ is maximum spanning tree.  Éric’s optimality proof via pointed homology.

## Shortest System of Arcs

$\Lambda = \Sigma / F \ C$, where $F$ is shortest-path forest from boundary and $C$ is maximum spanning tree.  Optimality proof via relative homology.

## Shortest (Co)Homology Bases
Matroid optimization
-->


## References


1. Sergio Cabello, Erin W. Chambers, and Jeff Erickson.  [Multiple-source shortest paths in embedded graphs](http://doi.org/10.1137/12086427). _SIAM J. Comput._ 42(4):1542–1571, 2013. arXiv:[1202.0314](https://arxiv.org/abs/1804.01045).

1. Sergio Cabello and Bojan Mohar.  [Finding shortest non-separating and non-contractible cycles for topologically embedded graphs](http://doi.org/10.1007/s00454-006-1292-5). _Discrete Comput. Geom._ 37(2):213–235, 2007.

1. David B. A. Epstein. [Curves on 2-manifolds and isotopies](http://doi.org/10.1007/BF02392203). _Acta Math._ 115:83–107, 1966.

1. Jeff Erickson. [Shortest non-trivial cycles in directed surface graphs](http://doi.org/10.1145/1998196.1998231). _Proc. 27th Ann. Symp. Comput. Geom._, 236–243, 2011.

1. Jeff Erickson, Emily Kyle Fox, and Luvsandondov Lkhamsuren. [Holiest minimum-cost paths and flows in surface graphs](http://doi.org/10.1145/3188745.3188904). _Proc. 50th Ann. ACM Symp. Theory Comput._, 1319–1332, 2018. arXiv:[1804.01045](https://arxiv.org/abs/1804.01045).

1. Jeff Erickson and Sariel Har-Peled. [Optimally cutting a surface into a disk](http://doi.org/10.1007/s00454-003-2948-z). _Discrete Comput. Geom._ 31(1):37–59, 2004. arXiv:[cs/0207004](https://arxiv.org/abs/cs/0207004).

1. Emily Kyle Fox. [Shortest non-trivial cycles in directed and undirected surface graphs](http://doi.org/10.1137/1.9781611973105.26).  _Proc. 24th Ann. ACM-SIAM Symp. Discrete Algorithms_, 352–364, 2013. arXiv:[1111.6990](https://arxiv.org/abs/1111.6990).

1. Martin Kutz. [Computing shortest non-trivial cycles on orientable surfaces of bounded genus in almost linear time](http://doi.org/10.1145/1137856.1137919). _Proc. 22nd Ann. Symp. Comput. Geom._, 430–438, 2006. arXiv:[cs/0512064](https://arxiv.org/abs/cs/0512064).

1. Carsten Thomassen.  [Embeddings of graphs with no short noncontractible cycles](http://doi.org/10.1016/0095-8956(90)90115-G). _J. Comb. Theory Ser. B_ 48(2):155–177, 1990.



## Aptly Named Sir

* Enforcing shortest-path and optimal-cycle uniqueness
* Tight cycles
* Directed graphs
* Shortest systems of loops, arcs, or cycles
* Shortest _homotopic_ paths, cycles, systems of loops, pants decompositions