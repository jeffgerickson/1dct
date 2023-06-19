---
numbersections: true
fontsize: 11pt
geometry:
- hmargin=1.25in
- vmargin=1in
header-includes: |
	\usepackage{amsmath}
    \usepackage[charter]{mathdesign}
    \usepackage[scale=0.96]{sourcesanspro}
    \usepackage[scale=0.96]{sourcecodepro}
    \usepackage[font={footnotesize,sf},labelfont=bf]{caption}
    \setcounter{section}{10}
---

# Straight-line Planar Maps$^\beta$

So far we have not assumed that planar embeddings are in any way well-behaved geometrically; edges can be embedded as arbitrarily pathological paths.  It is not hard to prove using a compactness argument (Similar to the simplicial approximation theorem for homotopy) that every planar graph has a _piecewise-linear_ planar embedding, where every edge is embedded as a simple polygonal path.

But in fact, every _simple_ planar graph has a _straight-line_ embedding, where every edge is represented by a single straight line segment.  More strongly, any planar _embedding_ is equivalent to (meaning it has the same rotation system as) a straight-line embedding.  This result was first proved (indirectly) by Steinitz (1916), and then independently rediscovered by Wagner (1936), [Cairns (1944)], Fáry (1948), Stein (1951), Stojaković (1959), and Tutte (1960), so of course it’s usually called “Fáry’s theorem”.

Non-simple planar graphs do not have straight-line embeddings; in any such embedding, parallel edges would coincide and loops would degenerate to points.  But every planar map can be transformed into a simple map by subdividing loops into cycles of length $3$ and parallel edges into paths of length $2$.  It (finally!) follows that any generic planar curve with $n$ vertices is equivalent to a planar _polygon_ with at most $3n$ vertices.

The existence of straight-line maps for simple planar graphs finally gives us the converse of Euler’s theorem:.

* Every rotation system with $n$ vertices, $m$ edges, and $f$ faces is the rotation system of a planar map **if and only if** $n-m+f = 2$.
* A signed Gauss code with $n$ symbols describes a planar curve **if and only if** it induces $n+2$ faces.

Moreover, all of the proofs described in this note are constructive; in particular, they all imply linear-time algorithms to construct straight-line embeddings from a given planar rotation system.

**Theorem:**
: _Given a planar rotation system for a planar graph $G$ with $n$ vertices and $m$ edges, we can compute an equivalent piecewise-linear embedding (or an equivalent straight-line embedding if $G$ is simple) in $O(n+m)$ time._



## Simple triangulations

Throughout this note, we’ll consider the special case of _simple triangulations_: simple planar maps in which every face is bounded by three edges.

**Triangulation Lemma (Fáry 1948):**
: _Every simple planar map can be extended to a simple triangulation by adding edges between existing vertices._

**Proof:**
: Fix a simple planar map $\Sigma$ with a non-triangular face $f$, and let $w,x,y,z$ be any four consecutive vertices on the boundary of $f$.  I claim that we can add at least one new edge $wy$ or $xz$ inside $f$ without creating any parallel edges.  The lemma follows form this claim by induction on the quantity $\sum_f (\deg(f)-3)$.

: For ease of presentation, assume $f$ is bounded.  Suppose $\Sigma$ contains an edge between $w$ and $y$, necessarily outside $f$.  The vertices $w$ and $y$  subdivide the boundary of $f$ into two paths, one through $x$ and the other through $z$.  Adding the edge $wy$ to those paths creates two cycles.  Without loss of generality, $x$ lies in the interior of the cycle $C$ that passes through $z$; as shown in Figure 1.

: Now suppose for the sake of argument that $\Sigma$ also contains an edge $xz$, again necessarily outside $f$.  This edge passes through the exterior of $C$ near $z$, but it also passes through the interior of $C$ near $x$.  So the Jordan Curve Theorem implies that $xz$ intersects $C$, contradicting the definition of embedding.  $\qquad\square$

![Proof of the triangulation lemma.](Fig/face-diagonal){ width=25% }

To compute a straight-line map $\overline\Sigma$ equivalent to an arbitrary simple planar map $\Sigma$, it suffices to add edges to $\Sigma$ to obtain a simple planar triangulation $T$, compute a straight-line map $\overline{T}$ equivalent to $T$, and then delete the (straightened) added edges.

In the following sections, I’ll describe three different constructions of straight-line triangulations equivalent to a given triangulation $T$.


## Inner Induction (Hole Filling)

**Lemma:**
: _Every simple planar triangulation with more than $3$ vertices has an interior vertex with degree at most $5$._

<!--
**Proof (Euler):**
: Let $T$ be a simple planar triangulation with $n>3$ vertices.  Every vertex of $T$ has degree at least $3$; otherwise, either $T$ is not simple or $T$ has a face with degree greater than $3$.  Euler’s formula implies that $T$ has exactly $3n-6$ edges, so the _average_ vertex degree is just less than $6$.  On the other hand, if $T$ has $k$ vertices with degree less than $6$, then $T$ has _at least_ $3n - 3k/2$ edges.  The inequality $3n-3k/2 \le 3n-6$  implies $k\ge 4$.  We conclude that $T$ has at least four vertices with degree less than $6$, at least one of which is an interior vertex. -->

**Proof:**
: Let $T$ be a simple planar triangulation with $n>3$ vertices.  Every vertex of $T$ has degree at least $3$; otherwise, either $T$ is not simple or $T$ has a face with degree greater than $3$.  Assign angle $\angle c = 1/3$ to every corner of $T$, so that every face $f$ has discrete curvature $\kappa(f) = 0$.  Then each vertex $v$ has curvature $\kappa(v) = 1 - \deg(v)/6 \le 1/2$; in particular, a vertex has positive curvature if and only if its degree is at most $5$.  The combinatorial Gauss-Bonnet theorem implies that $\sum_v \kappa(v) = 2$, so $T$ must have at least four vertices with positive curvature.  At least one of these is an interior vertex.


A simple polygon $P$ is _star-shaped_ if there is at least one interior point $q$  such that for each vertex $p$ of $P$, the segment $pq$ does not cross any edge of $P$.  The set of all such points $q$ is called the _kernel_ of $P$. 

**Lemma (Cairns 1944, Stojaković 1959):**
: _Every simple polygon with at most $5$ vertices is star-shaped._

**Proof (sketch):**
: Every convex polygon is trivially star-shaped.  Every simple quadrilateral has at most one reflex vertex; every simple pentagon has at most two reflex vertices, which are either adjacent or not.  In every case, we can verify by exhaustive case analysis that the kernel is non-empty; see the figure below.

![Every simple polygon with at most five vertices is star-shaped](Fig/vertex-links){ width=75% }

**Straight-Line Triangulation Theorem:**
: _Every simple planar triangulation is equivalent to a straight-line triangulation._

**Proof (Stojaković 1959):**
: We argue by induction on the number of vertices.  Let $T$ be any simple planar triangulation.  If $T$ has only $3$ vertices, then $T$ is clearly equivalent to any  (geometric) triangle $\overline{T}$.  So assume otherwise.

: Let $v$ be any interior vertex of $T$ with degree at most $5$.  Deleting $v$ creates a face $f$ with degree $\deg(v)$.  We extend $T\setminus v$ to a simple triangulation $T’$ by adding $\deg(v)-3$ diagonals inside $f$, following the Triangulation Lemma.  The induction hypothesis implies that $T’$ is equivalent to a straight-line triangulation $\overline{T}’$.  Deleting the diagonals yields a simple planar map $\overline{T\setminus v}$ equivalent to $T\setminus v$.  The face $\overline{f}$  of $\overline{T\setminus v}$ corresponding to $f$ is a simple polygon with $\deg(v)\le 5$ vertices.  Inserting a vertex $\overline{v}$ in the kernel of $\overline{f}$ and connecting $\overline{v}$ to every vertex of $\overline{f}$ yields a straight-line triangulation $\overline{T}$ equivalent to $T$.  $\qquad\square$

<!-- ## Variations on a Theme

### Separating Triangles (Fáry)

Fáry avoids using the Triangulation Lemma in the induction step as follows:

**Proof (Fáry):**
: After removing _any_ interior vertex $v$, triangulate the resulting face $f$ by joining _any_ vertex $w$ to all others.  Equivalently, choose any two bounded faces $uvw$ and $vwx$ that share an edge $vw$, and contracting $vw$ to a new vertex $v’$.  This contraction creates parallel pairs of edges $uv’$ and $v’w$; delete one edge from each pair.

: If the resulting map $\Sigma’$ is not simple, the original triangulation $T$ has a nontrivial _separating triangle_ $tvw$.  Let $T^+$ be the subgraph of $T$ obtained by deleting all vertices inside $tvw$, and let $T^-$ be the subgraph obtained by deleting all vertices outside $tvw$.  We can recursively construct straight-line triangulations $\overline{T^+}$ and $\overline{T^-}$ equivalent to $T^+$ and $T^-$.  Affinely mapping $\overline{T^-}$ into face $\overline{tvw}$ of $\overline{T^+}$ gives us a straight-line triangulation $\overline{T}$ equivalent to $T$.

: Recursion inside the inner triangulation $T^-$ implies that it is always possible to choose an edge $vw$ whose contraction yields a simple triangulation.  So we can proceed as follows:

: Choose any interior vertex $v$.  Find a neighbor $w$ of $v$ that is adjacent to only two other neighbors of $v$.  Delete $v$ and connect $w$ to all of $v$’s other neighbors, to obtain a map $\Sigma’$.  Recursively compute a straight-line map $\overline\Sigma’$.  Delete the edges from $\overline{w}$ to the other neighbors of $v$; let $f$ be the resulting $\deg(v)$-gonal face.  The kernel of $f$ includes vertex $\overline{w}$ and therefore has nonempty intersection with the interior of $f$.  Add a point $\overline{v}$ in the interior of the kernel, and Bob’s your uncle!


## Convex Polyhedral Embeddings (Stein)

Stein actually proves a stronger claim, establishing necessary and sufficient conditions for embeddings with convex faces.  A planar map is _weakly convex_ if the boundary of each face, including the outer face, is a convex polygon, possibly with collinear edges.  In particular, every edge of a weakly convex map is a straight line segment.  Every weakly convex planar map satisfies two topological conditions:

- The boundary of every face is a simple cycle.
- The intersection of any two facial cycles is connected: either empty, a single vertex, or a simple path.

Any planar map satisfying these two conditions is called _weakly polyhedral_.

**Weakly Convex Embedding Theorem (Stein):** _For every weakly polyhedral planar embedding, there is an equivalent weakly convex polyhedral embedding._


**Proof [¡¡BROKEN!!]:**
: Let $\Sigma$ be a weakly polyhedral embedding.  If the underlying graph of $\Sigma$ is the complete graph $K_4$---the simplest graph with a polyhedral embedding---finding an equivalent convex embedding is straightforward, so assume otherwise.  There are two cases to consider:

: Suppose $\Sigma$ has a vertex $v$ with degree $2$.  Let $u$ and $w$ be the neighbors of $v$.  The contracted map $\Sigma / uv$ is still weakly polyhedral.  So  the induction hypothesis implies that there is a convex embedding $\overline{\Sigma'}$ equivalent to $\Sigma / uv$.  We can obtain a convex embedding $\overline{\Sigma}$ equivalent to $\Sigma$ by adding a vertex $\overline{v}$ on the edge $\overline{uw}$ in $\overline{\Sigma'}$.

: On the other hand, suppose every vertex in $\Sigma$ has degree at least $3$. I claim that there is an interior edge $e$ such that $\Sigma \setminus e$ is weakly polyhedral.

: Deleting any interior edge $e$ merges the faces $f$ and $g$ on either side of $e$  into a single face $f\cup g$.  Suppose this new face has disconnected intersection with some other face $h$; equivalently, the union $f\cup g\cup h$ is not simply connected.  Then there is a closed curve $\gamma$ that starts at an endpoint of $e$, then passes through $f$ to some vertex in $f \cap h$, then passes through $h$ to some vertex in $g\cap h$, and finally passes through $g$ back to its starting endpoint of $e$.  The interior of $\gamma$ contains at least one face of $\Sigma$.

: Deleting $uv$ merges the two shores of $u\mathord\to v$ into a new face $f$.  The the inductive hypothesis implies that there is an equivalent convex embedding $\overline{\Sigma \setminus uv}$.  We can obtain a convex embedding $\overline{\Sigma}$ equivalent to $\Sigma$ by adding the line segment $\overline{uv}$ through the convex face $\overline{f}$ in $\overline{\Sigma'}$.  $\qquad\square$


![Two weakly convex embeddings of the cube graph obtained by Stein's algorithm.](Fig/cube-convex){ width=40% }

With a bit more effort, Stein's argument can be extended to show that every _strictly_ polyhedral embedding (where two faces intersect in at most one edge) is equivalent to a _strictly_ convex embedding (where no two edges of any face are collinear).  But we'll see a more interesting proof of that fact in the next lecture.
-->


## Outer Induction (Canonical Ordering)

Here is a second inductive proof of the Straight-Line Triangulation Theorem that does _not_ rely on Euler’s formula, roughly following an argument of de Fraysseix, Pach, and Pollack (1988).  This proof is close in spirit to early flawed inductive proofs of Euler’s formula, including Euler’s own flawed proof.

We actually prove the following stronger claim:  Let $\Sigma$ be any simple planar map whose interior faces are triangles and whose outer face is bounded by a simple cycle of length $h\ge 3$.  Let $v_1, v_2, \dots, v_h$ be the vertices of the outer face of $\Sigma$ in counterclockwise order.  Let $P$ be any convex polygon with vertices $p_1, p_2, \dots, p_h$ in counterclockwise order.  Then there is a straight-line planar map $\overline{\Sigma}$ that is equivalent to $\Sigma$, whose outer face is $P$, such that each outer vertex $v_i$ corresponds to the polygon vertex $p_i$.

The proof proceeds by induction on the number of vertices of $\Sigma$.  If $\Sigma$ is a single triangle, the claim is trivial, so assume otherwise.  There are two nontrivial cases to consider: Either $v_1$ and $v_{h-1}$ are the only neighbors of $v_h$ on the outer face, or $v_h$ has another neighbor $v_j$ on the outer face.


**Case 1: Only two neighbors on the outer face.**

: In this case, we recursively compute a straight-line planar map equivalent to $\Sigma\setminus v_h$ and then embed the edges incident to $v_h$ as line segments.

: Specifically, let $w_1, w_2, \dots, w_d$ be the neighbors of $v_h$, indexed in \emph{clockwise} order around $v_h$ so that $w_1 = v_{h-1}$ and $w_d = v_1$.  The vertices $w_2, \dots, w_{d-1}$ all lie in the complement of the outer face, and $\Sigma$ contains the edge $w_i w_{i+1}$ for every index $i$.  It follows that the outer face of the submap $\Sigma’ = \Sigma\setminus v_h$ is bounded by a simple cycle with vertices $v_1, v_2, \dots, v_{h-1}=w_1, w_2, \dots, w_d=v_1$.  Every bounded face of $\Sigma’$ is also a bounded face of $\Sigma$ and thus has degree $3$.

: Now let $\alpha$ be a convex arc from $p_1$ to $p_{h-1}$ inside the triangle $p_1 p_h p_{h-1}$.  (For example, $\alpha$ could be a circular arc tangent to $p_1 p_h$ at $p_1$ and tangent to $p_h p_{h-1}$ at $p_{h-1}$.)  Place $d$ evenly spaced points $q_1, q_2, q_3, \dots, q_d$ along $\alpha$, with $q_1 = p_{h-1}$ and $q_d = p_1$.  Finally, let $P'$ be the convex polygon obtained by replacing the edges $p_{h-1}p_h$ and $p_hp_1$ with the polygonal chain $q_1 q_2 \dots q_d$.

: ![Case 1: Remove vertex $v_h$ and recurse](Fig/straight-embedding-1){ width=45% }

: The inductive hypothesis implies that there is a straight-line embedding $\overline{\Sigma’}$ equivalent to $\Sigma’$ with outer face $P'$, that maps each vertex $v_i$ (with $i\ne h$) to the corresponding point $p_i$ and each vertex $w_i$ to the corresponding point $q_i$.  Adding the edges $p_h q_i$ gives us a straight-line map $\overline{\Sigma}$ equivalent to $\Sigma$ with outer face $P$ and the required vertex correspondences.


**Case 2: More than two neighbors on the outer face.**

: Now suppose $v_h$ is adjacent to some vertex $v_j$ on the outer face besides $v_1$ and $v_{h-1}$.  In this case, we split $\Sigma$ into two submaps along the edge $v_h v_j$, split the polygon $P$ into two smaller polygons along the diagonal $p_hp_j$, and recursively embed each fragment of $\Sigma$ into the corresponding fragment of $P$.

: Specifically, let $\Sigma^\sharp$ be the submap of $\Sigma$ obtained by deleting every vertex outside the simple cycle $(v_h, v_1, v_2, \dots, v_j, v_h)$.  (The outside of this cycle is well-defined by the Jordan Curve Theorem.)  Similarly, let $\Sigma^\flat$ be the submap of $\Sigma$ obtained by deleting every vertex outside the simple cycle $(v_h, v_j, v_{j-1}, \dots, v_{h-1}, v_h)$.  Both $\Sigma^\flat$ and $\Sigma^\sharp$ satisfy the conditions of our claim.

: ![Case 2: Split along the diagonal and recurse twice](Fig/straight-embedding-2){ width=45% }

: The line segment $p_hp_j$ partitions the polygon $P$ into two smaller convex polygons $P^\flat$ and $P^\sharp$.  The induction hypothesis give us straight-line embeddings $\overline{\Sigma^\flat}$ and $\overline{\Sigma^\sharp}$, respectively equivalent to $\Sigma^\flat$ and $\Sigma^\sharp$, with respective outer faces bounded by $P^\flat$ and $P^\sharp$, mapping each vertex $v_i$ to the corresponding point $p_i$.  In particular, in both straight-line embeddings, the the line segment $p_hp_j$ corresponds to the edge $v_hv_j$.  Combining the straight-line embeddings $\overline{\Sigma^\flat}$ and $\overline{\Sigma^\sharp}$ along $p_hp_j$ gives us the required straight-line embedding $\overline{\Sigma}$. 

The second case is actually redundant.  A simple recursive argument, similar to the proof that every polygon triangulation has two ears, implies that there are at least two non-adjacent vertices on the outer face with exactly two neighbors on the outer face.  It follows that the vertices of $\Sigma$ can be ordered $v_1, v_2, \dots, v_n$, so that after deleting any prefix $v_1, v_2, \dots, v_i$ where $i\le n-3$, the outer face of the remaining subgraph is bounded by a simple cycle, and the next vertex $v_{i+1}$ lies on the outer face.  This sequence of vertices is called a  _canonical ordering_ (or a _vertex-shelling order_) for $\Sigma$


## Schnyder Woods

In 1989, Walter Schnyder discovered a significant refinement of the previous proof, which implies that any $n$-vertex planar graph has a straight-line embedding whose vertices lie on an $(n-1)\times (n-1)$ integer grid.  Again, we consider only simple planar _triangulations_, where all faces have degree $3$, including the outer face. 

Let $T$ be a simple planar triangulation with $n$ vertices.  Schnyder defined two different ways to annotate features of $T$ with the colors red, green, and blue.  The first of these is a _Schnyder coloring_, which colors the interior corners subject to two conditions:

* The corners of each face are colored red, green, and blue in counterclockwise order.
* The corners around each internal vertex are colored red, then green, then blue in counterclockwise order.  In particular, each internal vertex is incident to at least one corner of each color.

![A Schnyder coloring of a simple triangulation](Fig/Schnyder-coloring){ width=40% }

A Schnyder coloring can be constructed in linear time as follows.  Color the outer vertices of $T$ red, green, and blue in counterclockwise order.  If $T$ has a single bounded face, its three corners inherit the colors of the incident vertices.  Otherwise, choose an arbitrary edge from a boundary vertex $u$ to an interior vertex $v$.  There are two cases to consider.

* Suppose $v$ has exactly two common neighbors with $u$.  The contraction $T/uv$ has two pairs of parallel edges; deleting one edge in each pair yields a smaller triangulation $T’$.  Recursively compute a Schnyder coloring for $T’$, and transfer the corner colors back to $T$.  Finally, there is only one way to consistently color the faces of $T$ on either side of $uv$; specifically, the corners incident to the boundary vertex $u$ inherit $u$’s color.

* If $v$ has at least three common neighbors with $u$, there must be a triangle $uvw$ in $T$ containing at least one vertex in its interior.  In this case, we recursively compute Schnyder colorings of the subgraphs of $G$ inside $uvw$ and outside $uvw$.  In both recursive subproblems the boundary vertex $u$ retains its originally assigned color, so that the resulting Schnyder colorings are compatible.

In fact, the second case is unnecessary.  By expanding the recursion from the second case, we see that the entire construction is carried out by a sequence of contractions; equivalently, an easy induction argument implies that at least one edge from each boundary vertex can be contracted immediately.  The Schnyder coloring in the figure above was computed by contacting the interior vertices toward the top (green) vertex in the order indicated by the vertex labels.

![Recursively computing a Schnyder coloring](Fig/Schnyder-contraction){ width=55% }

The second annotation, called a _Schnyder wood_, assigns a direction and a color to every internal edge of $T$.  Every internal edge in $T$ is incident to corners with all three colors, with one color appearing twice at one endpoint.  Schnyder orients each internal edge $e$ toward the endpoint with the same color twice, and assigns the repeated color to the edge.  The resulting coloring and orientation has the following useful properties:

* Each boundary vertex has only incoming internal edges, all with the same color as the vertex itself.
* Every internal vertex has exactly one outgoing edge of each color.
* At every internal vertex, incident edges appear in counterclockwise order as follows: one outgoing red, all incoming blue, one outgoing green, all incoming red, one outgoing blue, all incoming green.

![The Schnyder wood constructed from the coloring in Figure 5](Fig/Schnyder-wood){ width=40% }

We can also construct Schnyder woods directly using a sequence of edge contractions, just as we constructed Schnyder colorings.  Expanding an edge introduces one vertex and three edges; we orient the new edges away from the new vertex, and assign them the only colors consistent with the properties listed above.  Conversely, _every_ Schnyder wood can be constructed using this algorithm, contracting toward any of the outer vertices.  

![Recursively computing a Schnyder wood](Fig/Schnyder-edge-contraction){ width=55% }

Given any Schnyder wood, we can define an equivalent Schnyder coloring as follows.  For any interior corner, if the two edges are both leaving the corner vertex, assign the third color to the corner; otherwise, assign the color of the incoming edge(s) to the corner.

**Lemma:**
: _In any Schnyder wood, the edges of each color induce a spanning tree of the internal vertices, rooted at the boundary vertex with that color._

**Proof:**
: Without loss of generality, assume the Schnyder wood is constructed by repeatedly contracting to the green boundary vertex.  Each interior vertex has exactly one outgoing edge of each color, either leading to another interior vertex or the boundary vertex of that color.

: Number the interior vertices by the order in which they are contracted to the green boundary vertex, as shown in the figures.  Label the green boundary vertex $0$ and the other two boundary vertices $\infty$.  Call an edge $v\mathord\to w$ _increasing_ if the label of $w$ is larger than the label of $w$ and _decreasing_ otherwise.  Every green edge is decreasing, and every red and blue edge is increasing.  Thus, none of the red, green, or blue subgraphs contains a cycle; starting from any interior node, following edges of any fixed color leads to the outer vertex of that color.  $\qquad\square$

Hey, look, we have yet another proof of Euler’s formula!

**Euler’s formula:** 
: _For any planar map with $n$ vertices, $m$ edges, and $f$ faces, we have $n-m+f=2$._

**Proof:** 
: It suffices to prove the theorem for simple planar triangulations.  If $\Sigma$ is not a simple map, we can make it simple by splitting each edge into a path of three edges, by introducing two new vertices; the resulting simple graph has $n+2m$ vertices, $3m$ edges, and $f$ faces.  Similarly, if any face of $\Sigma$ has degree greater than~$3$, it must contain a path between two non-adjacent vertices; adding this path to the embedding yields a new planar map with $n$ vertices, $m+1$ edges, and $f+1$ faces.

: Consider any Schnyder wood of a simple planar triangulation $T$ with $n$ vertices, $m$ edges, and $f$ faces (including the outer face).  The edges of each color define a rooted tree with $n-2$ vertices, and therefore $n-3$ edges, and every interior  edgesbelongs to exactly one such tree.  It immediately follows that $m = 3(n-3)+3 = 3n-6$.  Finally, because every face is a triangle, we have $2m = 3f = 6n-12$, so $f = 2n-4$.  We conclude that $n-m+f = n - (3n-6) + (2n-4) = 2$.  $\qquad\square$

## Grid embedding

Now we assign integer coordinates to every interior vertex $v$ as follows.  There is a unique path of red edges, a unique path of green edges, and a unique path of blue edges from $v$ to the boundary.  These three paths partition the triangulation into three regions, which we color red, green, and blue as shown below.  Each region contains its clockwise bounding path---for example, the green region includes the blue path, including the blue boundary vertex---but not $v$ itself.

For purposes of defining these regions when $v$ is a boundary vertex, we orient the boundary edges clockwise and color each edge according to its head.  Thus, if $r,g,b$ are the red, green, and blue boundary vertices, the green region of $g$ contains every vertex except $g$ and $r$, the red region of $g$ contains only $r$, and the blue region of $g$ is empty. 

For each vertex $v$, let $r(v)$, $g(v)$, $b(v)$ respectively denote the number of vertices in the red, green, and blue regions of $v$.  By definition, we have $r(v) + g(v) + b(v) = n-1$ for every vertex $v$.

![Schnyder regions for an interior vertex with coordinates $(r,g,b) = (2,7,4)$.](Fig/Schnyder-regions){ width=45% }

**Lemma:**
: _Schnyder’s coordinates $(r(v), g(v), b(v))$ satisfy the following conditions:_
: (a) _For every red edge $v\mathord\to w$, we have $r(v) < r(w)$ and $g(v) \ge g(w)$ and $b(v) > b(w)$._
: (b) _For every green edge $v\mathord\to w$, we have $r(v) > r(w)$ and $g(v) < g(w)$ and $b(v) \ge b(w)$._
: (c) _For every blue edge $v\mathord\to w$, we have $r(v) \ge r(w)$ and $g(v) > g(w)$ and $b(v) < b(w)$._
: (d) _For every triangle ${uvw}$ whose corners at $u$, $v$, and $w$ are respectively red, green, and blue, we have $r(u) \ge r(v) > r(w)$ and $g(v) \ge g(w) > g(u)$ and $b(w) \ge b(u) > b(v)$._

**Proof:**
: Fix an arbitrary reference vertex $v$,  Color $v$ black, and color the other $n-1$ vertices according to the region that contains it.  When we move the reference vertex from $v$ to $w$ along a green edge $v\mathord\to w$, $v$ changes from black to green, $w$ changes from red to black, every green vertex remains green, and no vertex changes from red to blue or vice versa.  (Some red or blue vertices might become green, and the set of blue vertices might remain unchanged.)  Part (b) now follows immediately; parts (a) and (c) follow from similar arguments.

: Finally, part (d) follows by straightforward case analysis.  Up to a choice of colors, there are only two cases to consider: either the edges of $uvw$ have distinct colors (and therefore define a directed cycle), or two of the three edges have the same color (so the edges do not define a directed cycle). $\qquad\square$

**Theorem:**
: _Any planar embedding of a simple planar graph with $n$ vertices is equivalent to a straight-line embedding with vertices on the $(n-1)\times (n-1)$ integer grid._

**Proof:**
: As usual, it suffices to consider only simple triangulations.  Let $T$ be a simple planar triangulation with $n$ vertices.  Fix an arbitrary Schnyder coloring of $T$, and thus an arbitrary Schnyder wood.

: Assign each vertex $v$ of $T$ the integer coordinates $(g(v), b(v))$.  Let $uvw$ be an arbitrary triangle whose corners at $u$, $v$, and $w$ are respectively colored red, green, and blue by the Schnyder coloring.  The orientation of the new embedding of $uvw$ is given by the sign of the determinant
$$
	\left|\begin{matrix}
		1 & g(u) & b(u) \\
		1 & g(v) & b(v) \\
		1 & g(w) & b(w)
	\end{matrix}\right|
	~=~
	\big(g(v)-g(u)\big)\big(b(w)-b(u)\big) - \big(g(w)-g(u)\big)\big(b(v)-b(u)\big).
$$
The previous lemma implies that this expression is positive, which implies that the triangle is oriented counterclockwise.  Because every triangle is oriented consistently, no two triangles in the embedding can overlap, and therefore no pair of edges can intersect.  (The signed area of the outer triangle is equal to the sum of the signed areas of the interior triangles; if two triangles overlapped, the sum of the \emph{unsigned} areas of the interior triangles would be strictly larger than the unsigned area of the outer triangle!)  All vertex coordinates are integers between $0$ and $n-2$.  $\qquad\square$

The following figure shows the resulting embedding for our example graph.  Instead of embedding on the square grid, I’m using a grid of equilateral triangles, assigning each vertex $v$ _barycentric_ coordinates $(r(v), g(v), b(v))$.

![Schnyder’s barycentric grid embedding.](Fig/Schnyder-grid){ width=45% }



## References

Eventually....



## Not Appearing

* Looser grid embedding from canonical ordering or Schnyder face counts
* Schnyder woods for more general planar graphs (Felsner et al.)
* Weighted Schnyder embeddings
* Morphing between equivalent straight-line embeddings (better via Tutte)
* Convex polyhedral embeddings (Stein, better via Tutte)
* Steinitz’s theorem (better via Tutte)
* Distributive lattice of 3-orientations (maybe later)
* Koebe-Andreev circle packing (maybe later)

