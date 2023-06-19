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
    \def\thesection{23a}
---

# Planarization and Separation$^{\alpha/\beta}$

In this note I’ll describe how to generalize several results about planar separators to more complex surface maps.  These generalizations imply reductions from several problems on arbitrary surface maps to related (or even identical) problems on planar graphs, possibly with larger complexity.

The first step in any such reduction is to either delete or slice a subgraph of the input map to remove any interesting topology.  We’ve already seen one example of such a subgraph: A _cut graph_ in a surface map $\Sigma$ is a subgraph $X$ such that the sliced surface $\Sigma \mathbin{\backslash\!\!\backslash} X$ is a disk.  Unfortunately, it is easy to construct surface maps in which every cut graph uses a constant fraction of the edges, and we need sublinear complexity to support efficient reductions.

So instead we consider a weaker structure.  A _planarizing_ or _degenerating[^deg] subgraph_ of $\Sigma$ is any subgraph $X$ such that the sliced surface $\Sigma \mathbin{\backslash\!\!\backslash} X$ has genus $0$, but possibly with more than one boundary cycle.  Once we have planarizing subgraphs with sublinear complexity, we can use standard planar-separator techniques to balanced separators with sublinear complexity.

[^deg]: $\dots$because it removes all the genus.

Throughout this note, we fix a surface _triangulation_ $\Sigma$ with $n$ vertices and Euler genus $\bar{g} = o(n)$.  (Surface maps with Euler genus $\Omega(n)$ do not have small planarizing subgraphs or small separators.)  Euler’s formula implies that $\Sigma$ has exactly $3n-6+3\bar{g} < 6n$ edges and $2n-4+2\bar{g} < 4n$ faces.

## Multiple Short Cycles

**Lemma:**
_Let $\sigma$ and $\tau$ be cycles in a surface map $\Sigma$.  If either $\sigma$ or $\tau$ is a separating cycle, then $\sigma$ and $\tau$ cross an even number of times.  Equivalently, if $\sigma$ and $\tau$ cross an odd number of times, both $\sigma$ and $\tau$ are nonseparating._

**Lemma [Albertson and Hutchinson]:**
_Every orientable surface triangulation contains a nonseparating cycle of length at most $2\sqrt{n}$._

**Proof:**
: Let $\Sigma$ be an orientable surface triangulation, and let $\sigma$ be the shortest nonseparating cycle in $\Sigma$.  Let $\sigma^\flat$ and $\sigma^\sharp$ denote the two copies of $\sigma$ in the sliced map $\Sigma\mathbin{\backslash\!\!\backslash} \sigma$, and let $m$ denote the number of vertices in $\sigma$.

: Let $S$ be the smallest subset of vertices of $\Sigma\mathbin{\backslash\!\!\backslash} \sigma$ that separates $\sigma^\flat$ and $\sigma^\sharp$.  The subgraph of $\Sigma$ induced  by $S$ must contain (and therefore must _be_) a cycle $\tau$ that is homologous with $\sigma$ and therefore nonseparating.  Thus, $\tau$ has at least $m$ vertices.  Menger's Theorem now immediately implies that there are at least $m$ vertex-disjoint paths from $\sigma^\flat$ to $\sigma^\sharp$ in $\Sigma\mathbin{\backslash\!\!\backslash} \sigma$.

: On the other hand, let $\pi$ be the shortest path in $\Sigma\mathbin{\backslash\!\!\backslash} \sigma$ from a node in $\sigma^\flat$ to its clone in $\sigma^\sharp$.  The edges of $\pi$ comprise a cycle in $\Sigma$ that crosses $\sigma$ once and thus is nonseparating.  It follows that $\pi$ has length at least $m$.  At most $m/2$ edges in $\pi$ lie in either $\sigma^\flat$ or $\sigma^\sharp$.  Thus, every path from $\sigma^\flat$ to $\sigma^\sharp$ has at least $m/2$ edges.

: We conclude that $n\ge m^2/2$.   $\qquad\square$

Alberston and Hutchinson’s proof requires orientability.  If $\sigma$ is a one-sided cycle in a nonorientable surface map $\Sigma$, the sliced map $\Sigma \mathbin{\backslash\!\!\backslash} \sigma$ has a single boundary cycle that covers $\sigma$ twice.  However, a similar result can be proved for nonorientable surface maps by considering the oriented double cover $\Sigma^2$.

**Corollary [Gilbert, Hutchinson, and Tarjan]:**
_Any surface map $\Sigma$ with $n$ vertices and genus $g$ can be transformed into a genus-$0$ map by slicing along $g$ cycles of total length $O(g\sqrt{n})$._

**Proof:**
: Let $\Sigma$ be an orientable surface map with genus $g$.  Without loss of generality, we can assume that $\Sigma$ is a simple triangulation; otherwise, remove all loops, remove all but one edge in every family of homotopic parallel edges, and triangulate every face with more than three sides.  If $g=0$, there is nothing to do, so assume otherwise.  Let $\sigma$ be the shortest noncontractible cycle in $\Sigma$.  The map $\Sigma’ = \Sigma\mathbin{\backslash\!\!\backslash} \sigma$ has at most $n + 2\sqrt{n}$ edges has genus $g-1$.  The result now follows by induction.
$\qquad\square$

Hutchinson proved that every orientable surface triangulation contains a noncontractible cycle of length $O(\sqrt{n/g} \log g)$; the same inductive argument implies that we can planarize any orientable surface map by slicing along $g$ cycles of total length $O(\sqrt{ng} \log g)$.  Colin de Verdière, Hubard, and Lazarus proved that there are surface maps in which every noncontractible cycle has length at least $\Omega(\sqrt{n/g} \log g)$; so Hutchinson’s bound is tight in the worst case.  Nevertheless it is possible to compute (slightly) smaller planarizing subgraphs.

## Slabification

The following construction of a smaller planarizing subgraph is based on results of David Eppstein, which refines an earlier construction of Aleksandrov and Djidjev; similar techniques were also described by Hutchinson and Miller.  Eppstein’s construction uses the same notion of _depth contours_ as Miller’s planar cycle-separator algorithm, which we saw in Chapter 12.

Without loss of generality, assume that $\Sigma$ is a simple triangulation.  We start by building a  tree-cotree decomposition $(T, L, C)$, where $T$ is a breadth-first spanning tree rooted at an arbitrary source vertex $s$.  For any vertex $v$, let $\textsf{depth}(v)$ denote the unweighted shortest-path distance from $s$ to $v$, and define the depth of an edge or face to be the maximum depth of its vertices.

For any index $j$, the $j$th _depth contour_ $D_j$ of $\Sigma$ is the subgraph induced by edges incident to both a face with depth $j$ and a face with depth $j+1$.

For any integers $i<j$, let $\Sigma[i,j]$ denote the subcomplex of $\Sigma$ containing all faces $f$ such that $i < \textsf{depth}(f) \le j$, along with their incident edges and vertices; notice that the range of face-depths excludes the lower index $i$.  We refer to $\Sigma[i,j]$ as a _slab_ of $\Sigma$.  In particular, $\Sigma[0,j]$ is the subcomplex of vertices, edges, and faces with depth at most $j$, or equivalently, the component of $\Sigma \mathbin{\backslash\!\!\backslash} D_j$ containing $s$.  The boundary of $\Sigma[i,j]$ naturally partitions into its _upper_ boundary $D_{i-1}$ and its _lower_ boundary $D_j$.

For any subset $L’ \subseteq L$, let $Q(L’) = \bigcup \{ \textsf{loop}_T(\ell) \mid \ell\in L’ \}$.  In particular, $Q(L)$ is a (possibly unreduced) $Q$ut graph of $\Sigma$, and $Q(\varnothing)$ is the empty subgraph.

Finally, for all indices $i<j$, let $L[i,j] = L\cap \Sigma[i,j]$ and $Q[i,j] = \Sigma[i,j] \cap Q(L[i,j])$.  Each subgraph $Q[i,j]$ contains all edges $\ell\in L[i,j]$, along with shortest paths (through $T$) from the endpoints of $\ell$ “up” to the depth contour $D_{i-1}$.

**Lemma:**
_For all indices $i<j$, $Q[i,j]$ is a planarizing subgraph of $\Sigma[i,j]$._

**Proof:**
: Every submap of a genus-$0$ map has genus $0$, so it suffices to consider the spacial case $i=0$.  Let $\Sigma’$ be the surface map obtained from $\Sigma[0,j]$ by gluing a disk to each boundary cycle.

: The intersection $T’ = T \cap \Sigma’$ is a breadth-first spanning tree of $\Sigma[0,j]$, consisting of the first $j$ levels of the global breadth-first spanning tree tree $T$.

: The intersection $C \cap \Sigma’$ defines a forest in the dual map $(\Sigma’)^*$, which spans every face except the caps.  We can extend this coforest to a spanning cotree $C’$ by adding edges that are not in $T’$ (in fact, only edges on the boundary of $\Sigma[0,j]$).

: Thus, we have a tree-cotree decomposition $(T’, L’, C’)$ of $\Sigma’$, where $L’ = E(\Sigma’) \setminus (C’ \cup T’) \subseteq L[0,j]$.  It follows that $Q’ = Q(L’)$ is a cut graph for $\Sigma’$.  On the other hand, $Q’$ is a subgraph of $Q[i,j]$.  $\qquad\square$

For any integers $0 \le i < k$, let $D(i,k) = \bigcup\{D_j \mid j\bmod k = i\}$.  Slicing $\Sigma$ along these depth contours patitions it into several slabs:
$$	
	\Sigma \mathbin{\backslash\!\!\backslash} D(i,k)
	=
	\bigcup_a \Sigma[ak+i, (a+1)k+i].
$$
Let $Q(i,k)$ denote the corresponding subgraph of the cut graph $Q(L)$:
$$
	Q(i,k) = \bigcup_a Q[ak+i, (a+1)k+i].
$$
Finally, let $P(i,k) = D(i,k) \cup Q(i,k)$.  The previous lemma implies that $P(i,k)$ is a planarizing subgraph of $\Sigma$, for all indices $i$ and $k$.

**Lemma:**
_For some integers $i$ and $k$, the subgraph $P(i,k)$ has at most $2\sqrt{\bar{g}n}$ vertices._

**Proof:**
: For each endpoint $v$ of each edge in $L$, the subgraph $Q(i,k)$ contains the shortest path from $v$ to its nearest ancestor in $T$ that lies on the depth contour $D(i,k)$.  This path has length $(\textsf{depth}(v) - i) \bmod k$.  Moreover, $Q(i,k)$ is the union of all $\bar{g}$ such subpaths with $L$.  It follows that for any fixed $k$, we have
$$
	\sum_{i=0}^{k-1} |V(Q(i,k))| 
	\le
	\sum_{v\in V(L)} \sum_{i=0}^{k-1} (\textsl{depth}(v) - i)\bmod k
	=
	\bar{g} k(k-1) < \bar{g}k^2.
$$
Each vertex and edge of $\Sigma$ belongs to at most one depth contour $D_i$, so 
$$
	\sum_{i=0}^{k-1} |V(D(i,k))| \le n.
$$
We conclude that 
$$
	\sum_{i=0}^{k-1} |V(P(i,k))| \le \bar{g}k^2 + n
$$
which implies that for some index $i$, the subgraph $P(i,k)$ has at most $\bar{g}k + n/k$ vertices.  In particular, some subgraph $P(i,\sqrt{n/\bar{g}})$ has at most $2\sqrt{\bar{g}n}$ vertices.[^or2]  $\qquad\square$

[^or2]: More careful analysis implies the upper bound $\sqrt{\bar{g} n} = \sqrt{2gn}$ when $\Sigma$ is orientable.

Let $k^* = \sqrt{n/\bar{g}}$, and let $i^*$ be the index $i$ that minimizes the number of vertices in $P(i, k^*)$.  Euler’s formula implies that $P(i^*, k^*)$ has at most $12\sqrt{\bar{g}n}$ edges.

**Theorem:**
_Every surface triangulation $\Sigma$ with $n$ vertices and Euler genus $\bar{g} < n$ has a planarizing subgraph $P(i^*, k^*)$ with $O(\sqrt{\bar{g}n})$ vertices and edges, which can be computed in $O(n)$ time._

**Proof:**
: We can compute the breadth-first spanning tree $T$ and the depths of every vertex, edge, and face of $\Sigma$ in $O(n)$ time via (surprise, surprise) breadth-first search.  Computing the depth contours $D_j$, the number of vertices in each subgraph $D(i,k^*)$, and the optimal index $i^*$ in $O(n)$ time is straightforward.  Then for each endpoint $v$ of each edge in $L$, we walk upward in $T$ marking edges, until we encounter either a marked edge or a vertex in $D(i^*,k^*$)$.  Because each edge of $\Sigma$ is marked at most once, the total time to find the marked edges is their number plus $O(\bar{g})$, which is $O(n)$.   The marked edges and $L$ comprise the subgraph $Q(i^*,k^*)$.  $\qquad\square$

**Corollary:**
_Every surface triangulation $\Sigma$ with $n$ vertices and Euler genus $\bar{g} < n$ has a $(3/4)$-separator with $O(\sqrt{\bar{g}n})$ vertices and edges, which can be computed in $O(n)$ time._

**Proof:**
: The sliced surface $\Sigma \mathbin{\backslash\!\!\backslash} P(i^*, k^*)$ has at most one component with more than $3/4$ of the faces of $\Sigma$.  If there is such a component, apply the planar separator theorem within that component.  $\qquad\square$.


## Nice $r$-divisions

A _nice $r$-division_ of a surface map $\Sigma$ is a subdivision of $\Sigma$ into subcomplexes called _pieces_ with the following properties:

- Every face of $\Sigma$ lies in exactly one piece. 
- There are $O(n/r)$ pieces.
- Each piece has $O(r)$ vertices.
- Each piece has $O(\sqrt{r})$ _boundary_ vertices.
- Each piece has $O(1)$ _holes_ (boundary cycles).
- Each piece has genus $0$.

This definition is identical to our definition of nice $r$-divisions of planar maps, except for the last condition, which is obviously redundant if $\Sigma$ has genus $0$.  The definition implies that any nice $r$-division has a total of $O(n/\sqrt{r})$ boundary vertices.

Now suppose we wanted to extend our planarizing subgraph $P(i^*, k^*)$ to obtain a nice $r$-division.  The number of vertices in $P(i^*, k^*)$ suggests we should try $r = O(n/\bar{g})$.  Unfortunately, the partition $\Sigma \mathbin{\backslash\!\!\backslash} P(i^*, k^*)$ has $\Theta(\sqrt{\bar{g}n})$ face-connected componentnts, which is more than the $O(\bar{g})$ pieces we need for a nice $O(n/\bar{g})$-division.  Moreover, we have no control over the number of vertices, boundary vertices, and holes in each individual piece of $\Sigma \mathbin{\backslash\!\!\backslash} P(i^*, k^*)$.

We can modify $P(i^*, k^*)$ to obtain a nice $r$-division, first by removing redundant cycles, and then by adding cycles to make the pieces nice.

First, consider the face-connected fragments of the map $\Sigma \mathbin{\backslash\!\!\backslash} D(i^*, k^*)$ obtained by slicing only along the short depth contours $D(i^*,k^*)$.  We call each fragment _interesting_ if it contains at least one path through $T$ from an endpoint of an edge in $L$ to the upper boundary of that fragment.  There are clearly at most $2\bar{g}$ interesting fragments.  Let $U(i^*,k^*)$ denote the Union of the Upper boundaries of the interesting fragments, and let $P’(i^*,k^*) = U(i^*,k^*) \cup Q(i^*,k^*)$.

**Lemma:**
_$P’(i^*,k^*)$ is a planarizing subgraph of $\Sigma$ with $O(\sqrt{\bar{g}n})$ vertices and edges.  Moreover, $\Sigma \mathbin{\backslash\!\!\backslash} P’(i^*, k^*)$ consists of $O(\bar{g})$ face-connected fragments._

The subgraph $P’(i^*, k^*)$ induces a partition $\mathcal{P}$ of $\Sigma$ into $O(\bar{g})$ genus-$0$ pieces, with a _total_ of $O(\sqrt{\bar{g}n})$ boundary vertices and $O(\bar{g})$ holes.  But the vertices, boundary vertices, and holes are not distributed evenly among the pieces, so we do not yet have a nice $O(n/\bar{g})$-division.  We apply a variant of the algorithm of Klein, Mozes, and Sommer to construct a nice $O(n/bar{g})$-division of each face-connected fragment of $\Sigma \mathbin{\backslash\!\!\backslash} P’(i^*, k^*)$ in three phases.

- We repeatedly split pieces with more than $n/\bar{g}$ vertices using balanced cycle separators, until every piece has at most $n/bar{g})$ vertices.  This phase requires at most $O(\bar{g})$ splits.  Naively, if we compute each cycle separator independently, the total time for this phase of the algorithm is $O(n\log g)$, but the time reduces to $O(n)$ if we use the faster Klein-Mozes-Sommer algorithm.  The total number of boundary vertices at the end of this phase is $O(\sqrt{\bar{g}n})$.

- Next, we repeatedly split pieces whose boundary has more than $\sqrt{n/\bar{g}}$ vertices until no such pieces remain.  We split each piece by giving each boundary vertex weight $1$ and each interior vertex weight $0$, and then computing a balanced cycle separator.  Finding a cycle separator in a piece with $O(n/\bar{g})$ vertices takes $O(n/\bar{g})$ time.  This phase requires at most $O(\bar{g})$ splits to evenly partition the $O(\sqrt{\bar{g}n})$ boundary vertices, so the total time for this phase is $O(n)$, even if we compute each cycle separator independently.

- Finally, we repeatedly split pieces that have more than (say) $20$ boundary cycles until no such pieces remain.  We split each piece by triangulating each hole with one additional vertex, giving the added vertices weight $1$ and all other vertices weight $0$, and then computing a balanced cycle separator.  Finding a cycle separator in a piece with $O(n/\bar{g})$ vertices takes $O(n/\bar{g})$ time.  This phase requires at most $O(\bar{g})$ splits to evenly partition the $O(\bar{g})$ holes, so the total time for this phase is $O(n)$.

**Theorem:**
_Given a surface map $\Sigma$ with $n$ vertices and Euler genus $\bar{g} = o(n)$, we can compute a nice $(n/\bar{g})$-division of $\Sigma$ in $O(n)$ time._

We can now compute $r$-divisions for smaller values of $r$, or even hierarchies of such $r$0divisions, by applying planar algorithms to the individual pieces of this $(n/\bar{g})$-division.

**Corollary:**
_Given a surface map $\Sigma$ with $n$ vertices and Euler genus $\bar{g} = o(n)$, and any integer $r < n/\bar{g}$, we can compute a nice $r$-division of $\Sigma$ in $O(n)$ time._

**Corollary:**
_Given a planar triangulation $\Sigma$ with $n$ vertices, and any exponentially decreasing vector $\vec{r} = (r_1, r_2, \dots, r_t)$ with $r_1 < n/\bar{g}$, we can construct a good $\vec{r}$-division of $\Sigma$ in $O(n)$ time._

## Applications

This construction allows us to extend several algorithms for planar maps to surface maps with no change in the running time, provided the genus is sufficiently small.  For example, using the planar algorithms described earlier in these notes, we obtain the following:

**Corollary:**
_Given a surface map $\Sigma$ with $n$ vertices and genus $g = o(n/\log^2 n)$, with non-negatively weighted darts, we can compute a single-source shortest path tree in $\Sigma$ in $O(n\log\log n)$ time._

(This time bound can be improved to $O(n)$.)

**Corollary:**
_Given a surface map $\Sigma$ with $n$ vertices and genus $g = o(n/\log^2 n)$, with arbitrarily weighted darts, we can compute either a single-source shortest path tree or a negative cycle in $\Sigma$ in $O(n\log^2 n/\log\log n)$ time._

The only significant subtlety in generalizing the planar algorithms is some pieces in the relevant $r$-divisions can be adjacent to themselves across one of the paths in $Q(i^*,k^*)$.  Thus, “boundary vertex” does not mean “vertex that belongs to more than one piece”; rather, pieces are defined by slicing the surface map along certain paths and cycles, and “boundary vertex” means a vertex on one of these slicing curves.  The dense-distance graph of a piece is defined by shortest boundary-to-boundary paths _within_ the piece, even though there may be shorter paths that use only vertices and edges of the piece but that  that cross the boundary of the piece.

## References

1. Lyudmil Aleksandrov and Hristo Djidjev. [Linear algorithms for partitioning embedded graphs of bounded genus](https://doi.org/10.1137/S0895480194272183). _SIAM J. Discrete Math._ 9(1):129–150, 1996.

1. Éric Colin de Verdière, Alfredo Hubard, and Arnaud de Mesmay. [Discrete systolic inequalities and decompositions of triangulated surfaces](http://doi.org/10.1007/s00454-015-9679-9). _Discrete Comput. Geom._ 53(3):587–620, 2015.

1. Hristo N. Djidjev. A separator theorem. _C. R. Acad. Bulg. Sci._ 34:643–645, 1981.

1. David Eppstein.  [Dynamic generators of topologically embedded graphs](https://dl.acm.org/doi/10.5555/644108.644208).  _Proc. 14th Ann. ACM-SIAM Symp. Discrete Algorithms_, 599–608, 2003. arXiv:[cs/0207082](https://arxiv.org/abs/cs/0207082).

1. John R. Gilbert, Joan P. Hutchinson, and Robert Endre Tarjan. [A separator theorem for graphs of bounded genus](http://doi.org/10.1016/0196-6774(84)90019-1). _J. Algorithms_ 5(3):391–407, 1984.

1. Joan P. Hutchinson. [On short noncontractible cycles in embedded graphs](https://doi.org/10.1137/0401020). _SIAM J. Discrete Math._ 1(2):185–192, 1988.

1. Joan P. Hutchinson and Gary L. Miller. [Deleting vertices to make graphs of positive genus planar](https://doi.org/10.1016/B978-0-12-386870-1.50011-3). _Discrete Algorithms and Complexity Theory, Proc. Japan-US Joint Seminar, Kyoto, Japan_, 81–98, 1987. Academic Press.


## Aptly Named Sir

- Local approximation (Baker-Eppstein)
