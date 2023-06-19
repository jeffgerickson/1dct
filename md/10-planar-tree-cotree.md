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
    \usepackage[font={footnotesize,sf},labelfont=bf]{caption}
    \setcounter{section}{9}
---

# Tree-Cotree Decompositions$^\beta$


## Important graph definitions (yawn)

We need to establish definitions for a few important structures in graphs.  Most of these are likely already familiar; I recommend using this list as later reference rather than reading it as text. ***Move to end of previous note?***

**walk**:
: A sequence $\langle s, d_1, d_2, \dots, d_k, t \rangle$ where $s$ and $t$ are vertices and each $d_i$ is a dart, such that $\textsf{tail}(d_1) = s$ and $\textsf{head}(d_1) = t$ and $\textsf{head}(d_i) = \textsf{tail}(d_{i+1})$ for each index $i$

**length of a walk**:
: The number of darts in the walk.  The walk $\langle s, d_1, \dots, d_k, t \rangle$ has length $k$.

**trivial walk**:
: A walk $\langle s, s \rangle$ with length $0$.

**closed walk**:
: A walk $\langle s, d_2, \dots, d_k, t \rangle$ such that $s = t$.

**open walk**:
: A walk that is either trivial or not closed

**walk from $s$ to $t$**:
: A walk with specified initial vertex $s$ and final vertex $t$

**$s$ can reach $t$**:
: There is a walk from $s$ to $t$.  This is an equivalence relation.

**component**:
: An equivalence class for “can reach”

**connected graph**:
: A graph with exactly one component

**simple walk**:
: A walk $\langle s, d_1, \dots, d_k, t \rangle$ such that each vertex is the head of at most one dart $d_i$.

**path**:
: A simple open walk, or the subgraph induced by a simple open walk

**even subgraph**:
: A subgraph in which every vertex has even degree.  

**cycle**:
: A simple non-trivial closed walk, or the subgraph induced by such a walk.  A minimal non-empty even subgraph.

**loop**:
: A cycle with length $1$, or an edge whose endpoints coincide.

**cut**:
: A partition of the vertices $V$ into two non-empty subsets $S$ and $V\setminus S$

**edge cut**:
: All edges with one endpoint in $S$ and the other in $V\setminus S$, for some subset $S\subseteq V$

**bond**:
: A minimal nonempty edge cut

**bridge**:
: An edge cut containing a single edge; that is, a single edge whose deletion disconnects the graph

**acyclic graph**:
: A graph containing no cycles


## Deletion and Contraction

Let’s begin by discussing two operations for modifying abstract graphs. Let $G$ be an arbitrary connected (but _not_ necessarily planar) abstract graph with $n$ vertices and $m$ edges.  

_Deleting_ an edge $e$ from G yields a smaller graph $G \setminus e$ with $n$ vertices and $m-1$ edges.  We also write $G \setminus v$ to denote the graph obtained from $G$ by deleting a vertex $v$ and all its incident edges.  Deleting a bridge disconnects the graph.

Symmetrically, if $e$ is not a loop, then _contracting_ $e$ merges the endpoints of $e$ into a single vertex and destroys the edge, yielding a smaller graph $G \mathbin/ e$ with $n - 1$ vertices and $m-1$ edges.  Contracting a loop is simply forbidden by definition.  Contracting a loop is not (yet) defined.  If $G$ contains edges parallel to $e$, those edges survive in $G \mathbin/ e$ as loops.

![Contraction and deletion.](Fig/contract-delete){ width=95% }

A _subgraph_ of a graph $G$ is another graph obtained from $G$ by deleting edges and isolated vertices; a _proper_ subgraph of $G$ is any subgraph other than $G$ itself.  (We often equate subgraphs of $G$ with subsets of the edges of $G$.)  Deleting any subset of edges $E’ \subseteq E$ _that does not contain a bond_ yields a connected proper subgraph $G \setminus E’$.  

Symmetrically, contracting any subset of edges  $E’ \subseteq E$ _that does not contain a cycle_ yields a _proper minor_ $G \mathbin/ E’$.  A minor of $G$ is any graph obtained from a subgraph of $G$ by contracting edges; a _proper_ minor of $G$ is any minor other than $G$ itself.  

The inverse of deletion is called _insertion_, and the inverse of contraction is called _expansion_.  If $G$ is a (proper) subgraph of another graph $H$, then $H$ is a _(proper) supergraph_ of $G$; similarly, if $G$ is a (proper) minor of $H$, then $H$ is a _(proper) major_ of $G$.


## Spanning trees

A _spanning tree_ of a graph $G$ is a connected, acyclic subgraph of $G$ (more more succinctly, a _subtree_ of $G$) that includes every vertex of $G$.  We leave the following lemma as an exercise for the reader.

**Lemma:**
: _Let $G$ be a connected graph, and let $e$ be an edge of $G$._
: * _If $e$ is a loop, then every spanning tree of $G$ excludes $e$._
: * _If $e$ is not a loop, then for any spanning tree $T$ of $G\mathbin/e$, the subgraph $T\cup e$ is a spanning tree of $G$._
: * _If $e$ is a bridge, then every spanning tree of $G$ includes $e$._
: * _If $e$ is not a bridge, then every spanning tree of $G \setminus e$ is also a spanning tree of $G$._

This lemma immediately suggests the following general strategy to compute a spanning tree of any connected graph: For each edge $e$, either contract $e$ or delete $e$.  Loops must be deleted and bridges must be contracted; otherwise, the decision to contract or delete is arbitrary.  (It is impossible for an edge to be both a bridge and a loop!)  The previous lemma implies by induction that the set of contracted edges is a spanning tree of $G$, regardless of the order that edges are visited, or which non-loop non-bridge edges are deleted or contracted.

![Building a spanning tree by contraction and deletion.](Fig/spanning-tree){ width=95% }

In practice, algorithms that compute spanning trees do not _actually_ contract or delete edges; rather, they simply label the edges as either belonging to the spanning tree or not.  In this context, the previous lemma can be rewritten as follows:

**Spanning Tree Lemma:**
: _Let $G$ be a connected graph._
: * _Each spanning tree of $G$ excludes at least one edge from each cycle in $G$._
: * _For every edge e of every cycle of $G$, there is a spanning tree of $G$ that excludes $e$._
: * _Every spanning tree of $G$ includes at least one edge from each bond in $G$._
: * _For every edge $e$ of every bond of $G$, there is a spanning tree of $G$ that includes $e$._

**Corollary:**
: _If the edges of a connected graph $G$ are arbitrarily colored red or blue, so that each cycle in $G$ has at least one red edge and each bond in $G$ has at least one blue edge, then the subgraph of blue edges is a spanning tree of $G$._

Given a connected graph with $n$ vertices and $m$ edges, we can compute a spanning tree in $O(n+m)$ time using any number of graph traversal algorithms, the most common of which are _depth-first search_ and _breadth-first search_.  These algorithms can be seen as variants of the red-blue coloring algorithm, where the order in which edges are colored (or equivalently, the choice of edges to delete or contract) is determined on the fly as the algorithm explores the graph.


## Deletion and Contraction in Planar Maps

Contraction and deletion play complementary roles in planar maps.  For example, contracting any (non-loop) edge identifies its two endpoints; deleting any (non-bridge) edge merges its two shores.  This resemblance is not merely incidental; in fact, contraction and deletion are _dual_ operations.  Contracting an edge in any map $\Sigma$ is equivalent to deleting the corresponding edge in $\Sigma^*$ and vice versa.

Hopefully this duality is intuitively clear, but we can make it formally trivial by describing how deletion and contraction are _implemented_ in planar maps.  Let $\textsf{succ}$ denote the successor permutation of a planar map $\Sigma$, and let $\textsf{succ}^* = \textsf{rev}\circ \textsf{succ}$ denote its dual successor permutation, which is also the successor permutation of the dual map $\Sigma^*$.  Fix an arbitrary edge $e$ of $\Sigma$. 

**Deletion:**
: Suppose $e$ is not a bridge.  Then $\Sigma \setminus e$ is a planar map that contains every dart in $\Sigma$ except $e^+$ and $e^-$.  Let $\textsf{succ}\setminus e$ and $\textsf{succ}^*\setminus e$ denote the induced primal and dual successor permutations of $\Sigma\setminus e$.  Then for any dart $d$ in $\Sigma\setminus e$, we have
$$
	(\textsf{succ}\setminus e)(d) = \begin{cases}
		\textsf{succ}(\textsf{succ}(\textsf{succ}(d)))
			& \text{if $\textsf{succ}(d) \in e$ and
						$\textsf{succ}(\textsf{succ}(d)) \in e$,}\\
		\textsf{succ}(\textsf{succ}(d))
			& \text{if $\textsf{succ}(d) \in e$,}\\
		\textsf{succ}(d) & \text{otherwise.}
	\end{cases}
$$
The first case occurs when $e$ is an empty loop based at the head of $d$.  See the figure below.
In other words, to find the successor of $d$ in $\Sigma \setminus e$, we repeatedly follow successor pointers until we reach a dart that is not in the deleted edge $e$.

: It follows that the dual successor permutation changes as follows:
$$
	(\textsf{succ}^*\setminus e)(d) = \begin{cases}
		\textsf{succ}^*(\textsf{succ}(\textsf{succ}(d)))
			& \text{if $\textsf{succ}(d) \in e$ and
						$\textsf{succ}(\textsf{succ}(d)) \in e$,}\\
		\textsf{succ}^*(\textsf{succ}(d))
			& \text{if $\textsf{succ}(d) \in e$,}\\
		\textsf{succ}^*(d) & \text{otherwise.}
	\end{cases}
$$

   ![Deleting an edge: Default case and empty loop](Fig/delete-cases){ width=45% }

**Contraction:**
: Suppose $e$ is not a loop.  Then $\Sigma \mathbin/ e$ is a planar map that contains every dart in $\Sigma$ except $e^+$ and $e^-$.  Let $\textsf{succ} \mathbin/ e$ and $\textsf{succ}^* \mathbin/ e$ respectively denote the induced primal and dual successor permutations of $\Sigma \mathbin/ e$.  Then for any dart $d$ of $\Sigma \mathbin/ e$, we have
$$
	(\textsf{succ}^*\mathbin/ e)(d) = \begin{cases}
		\textsf{succ}^*(\textsf{succ}^*(\textsf{succ}^*(d)))
			& \text{if $\textsf{succ}^*(d) \in e$ and
						$\textsf{succ}^*(\textsf{succ}^*(d)) \in e$,}\\
		\textsf{succ}^*(\textsf{succ}^*(d))
			& \text{if $\textsf{succ}^*(d) \in e$,}\\
		\textsf{succ}^*(d) & \text{otherwise.}
	\end{cases}
$$
The first case occurs when one endpoint of $e$ has degree $1$ and the head of $d$ is the other endpoint of $e$.  See the figure below.  In other words, to find the _dual_ successor of $d$ in $\Sigma\mathbin/e$, we chase _dual_ successor pointers until we reach a dart that is not in the contracted edge $e$.

: It follows that the primal successor permutation changes as follows:
$$
	(\textsf{succ} \mathbin/ e)(d) = \begin{cases}
		\textsf{succ}(\textsf{succ}^*(\textsf{succ}^*(d)))
			& \text{if $\textsf{succ}(d) \in e$ and
						$\textsf{succ}^*(\textsf{succ}^*(d)) \in e$,}\\
		\textsf{succ}(\textsf{succ}^*(d))
			& \text{if $\textsf{succ}(d) \in e$,}\\
		\textsf{succ}(d) & \text{otherwise.}
	\end{cases}
$$

![Contracting an edge: Default case and leaf](Fig/contract-cases){ width=45% }

Both of these formulas are trivially correct when we either delete or contract the only edge in a one-edge map, because the resulting trivial map has no darts.  Assuming standard data structures, any edge can be contracted or deleted in $O(1)$ time.

The following lemma is now purely mechanical. 

**Lemma (contraction $\leftrightharpoons$ deletion):**
: _Fix a planar map $\Sigma$, and let $e$ be any edge in $\Sigma$._
: (a) _If $e$ is not a loop, then $e^*$ is not a bridge and $(\Sigma \mathbin/ e)^* = \Sigma^* \setminus e^*$._
: (b) _If $e$ is not a bridge, then $e^*$ is not a loop and $(\Sigma\setminus e)^* = \Sigma^* \mathbin/ e^*$._


If we delete a bridge using the formulas above, the components of $G\setminus e$ become embedded independently, each on its own plane/sphere; instead of merging two faces into one, the deletion breaks one face (on either side of the deleted edge) into two.  Symmetrically, if we contract a loop using the formula above, instead of merging two vertices into one, we split the single endpoint of the loop into two, splitting the graph into two independent subgraphs, one “inside” the loop and the other “outside”.


![Contraction and deletion in a planar map $\Sigma$ both induce smoothing in the medial map $\Sigma^\times$.](Fig/contract-delete-medial){ width=95% }


## Tree-Cotree Decompositions

**Lemma (even subgraph $\leftrightharpoons$ edge cut):**
: _Fix a planar map $\Sigma$.  A subset $H$ of the edges of $\Sigma$ is an even subgraph if and only if the corresponding subset $H^*$ of edges in $\Sigma^*$ is an edge cut._

**Proof:**
: Let $H$ be an even subgraph of $\Sigma$.  Let $C_1, C_2, \dots, C_k$ be edge-disjoint cycles in $\Sigma$ whose union is $H$.  Color each vertex of $\Sigma^*$ black if it lies in the interior of an odd number of cycles $C_i$, and white otherwise.  Then $H$ is the subgraph of edges with one white shore and one black shore.  It follows that $H^*$ is the subgraph of dual edges with one endpoint of each color; in other words, $H^*$ is an edge cut in $\Sigma^*$.

: On the other hand, let $H^*$ is an edge cut in $\Sigma^*$.  Then it is possible to color the vertices of $\Sigma^*$ black and white, so that $H^*$ is the subset of edges with one white endpoint and one black endpoint. The primal subgraph $H$ contains precisely the edges of $\Sigma$ with one white shore and one black shore.  Every vertex of $\Sigma$ is incident to an even number of such edges.  We conclude that $H$ is an even subgraph of $\Sigma$.

**Corollary (cycle $\leftrightharpoons$ bond):**
: _A subgraph $H$ of a planar map $\Sigma$ is a cycle if and only if the corresponding subgraph $H^*$ of $\Sigma^*$ is a bond._

**Proof:**
: A cycle is a minimal non-empty even subgraph; a bond is a minimal non-empty edge cut.

: Equivalently, a cycle is a minimal subset of edges that cannot all be contracted, and a bond is a minimal subset of edges that cannot all be deleted.

**Corollary (spanning tree $\leftrightharpoons$ spanning cotree):**
: _Fix a planar map $\Sigma = (V, E, F)$, and let $T \sqcup C$ be a partition of $E$.  Then $T$ defines a spanning tree of $\Sigma$ if and only if $C^* \subset E^*$ defines a spanning tree of $\Sigma^*$._

**Proof:**
: Let $T$ be an arbitrary spanning tree of $G$, and let $C^* = E^*\setminus T^*$ be the complementary dual subgraph of $\Sigma^*$.  The Spanning Tree Lemma implies that every cycle of $\Sigma$ excludes at least one edge in $T$, and every bond of $\Sigma$ contains at least one edge in $T$.  Cycle-bond duality implies that every bond of $\Sigma^*$ contains at least one edge in $C^*$, and every cycle of $\Sigma^*$ excludes at least one edge in $C^*$.  We conclude that $C^*$ is a connected acyclic spanning subgraph of $\Sigma^*$, or in other words, a spanning tree of $\Sigma^*$.

![A tree-cotree decomposition of a planar map and its dual.](Fig/planar-tree-cotree){ width=25% }

The partition $T\sqcup C$ of edges of a planar map into primal and dual spanning trees is called a _tree-cotree decomposition_.  Notice that either the primal spanning tree $T$ or the dual spanning tree $C^*$ can be chosen arbitrarily.

The duality between cycles and bonds was first proved by Hassler Whitney.  Whitney also proved the following converse result.  An _algebraic dual_ of an abstract graph $G$ is another abstract graph $G^*$ with the same set of edges, such that a subset of edges defines a cycle in $G$ if and only if the same subset defines a bond in $G^*$.

**Theorem (Whitney (1932)):**
_A connected abstract graph is planar if and only if it has an algebraic dual._

## Euler’s Formula

Arguably the earliest fundamental result in combinatorial topology is a simple formula first _published_ by Leonhard Euler, but described in full generality over a century earlier by René Descartes, and described for the special case of Platonic solids by Francesco Maurolico a century before Descartes.  I’ll provide two short proofs here, one directly inductive, the other relying on tree-cotree decompositions.

**Euler’s Formula for Planar Maps.**
: _For any connected planar map with $n$ vertices, $m$ edges, and $f$ faces, we have $n-m+f = 2$._

**Proof (by induction):**
: Fix an arbitrary planar map $\Sigma$ with $n$ vertices, $m$ edges, and $f$ faces. If $\Sigma$ has no edges, it has one vertex and one face.  Otherwise, let $e$ be any edge of$\Sigma$; there are two overlapping cases to consider.
: * If $e$ is not a bridge, then deleting $e$ yields a planar map $\Sigma\setminus e$ with $n$ vertices, $m-1$ edges, and $f-1$ faces.  The induction hypothesis implies that $n-(m-1)+(f-1) = 2$.
: * If $e$ is not a loop, then contracting $e$ yields a planar map $\Sigma\mathbin/e$ with $n-1$ vertices, $m-1$ edges, and $f$ faces.  The induction hypothesis implies that $(n-1)-(m-1)+f = 2$.

: In all cases, we conclude that $n-m+f=2$.

**Proof (von Staudt 1847):**
: Fix an arbitrary planar map $\Sigma$ with $n$ vertices, $m$ edges, and $f$ faces.  Let $T$ be an arbitrary spanning tree of $\Sigma$.  Because $T$ has $n$ vertices, it also has $n-1$ edges.  The complementary dual subgraph $C^* = (E\setminus T)^*$ is a spanning tree of $\Sigma^*$.  Because $C^*$ has $f$ vertices, it also has $f-1$ edges.  Every edge in $\Sigma$ is either an edge of $T$ or the dual of an edge in $C^*$, but not both.  We conclude that $m = (n-1)+(f-1)$.

There are many many other proofs of Euler’s formula.  David Eppstein has [a web page describing more than twenty of them](https://www.ics.uci.edu/~eppstein/junkyard/euler/), but even David’s list is incomplete.  For example, we can leverage our earlier proof of Euler’s formula for planar _curves_, after establishing a few additional definitions.

Recall that the _medial map_ $\Sigma^\times$ of a planar map $\Sigma$ is another planar map whose vertices correspond to edges of $\Sigma$, whose edges correspond to corners of $\Sigma$, and whose faces correspond to vertices and faces of $\Sigma$.  Every medial map $\Sigma^\times$ is either a simple cycle or 4-regular, and therefore is the image map of a connected planar multicurve.  (Steinitz used medial maps (“$\Theta$-Prozeß”) to reduce his eponymous theorem about graphs of convex polyhedra to an argument about curves.)

![The medial map of a planar map.](Fig/derived-maps/medial){ width=40% }

**Proof (via medial homotopy):**
: Fix an arbitrary planar map $\Sigma$ with $n$ vertices, $m$ edges, and $f$ faces.  The medial map $\Sigma^\times$ is the image map of a connected planar multicurve with $2m$ vertices and $n+f$ faces.  We already proved by induction[^almost] that every connected planar multicurve with $N$ vertices has exactly $N+2$ faces.  We conclude that $n+f = 2m+2$.

[^almost]: Well, okay, we only proved this formula for _curves_, but extending our inductive proof to multicurves requires us to consider only one additional case.  Suppose some $2\to0$ move disconnects a multicurve $\Gamma$ into two smaller connected multicurves $\Gamma^\sharp$ and $\Gamma^\flat$.   The original map $\Gamma$ has $n^\sharp + n^\flat + 2$ vertices and $f^\sharp + f^\flat$ faces (including the deleted bigon and the common outer face), and the induction hypothesis implies that $f^\sharp = n^\sharp + 2$ and $f ^\flat = n^\flat+2$. 
Later we will see yet another proof of Euler’s formula (not on David’s list) based on Schnyder woods.

## The Combinatorial Gauss-Bonnet Theorem

I’ll close this lecture by proving a powerful reformulation of Euler’s formula.

Suppose we assign a value $\angle c$ to each corner $c$ of a planar map $\Sigma$, called the _exterior angle_ at $c$.  Intuitively, you should think of $\angle c$ as the signed angle between the tangent vectors to two darts $d$ and $\textsf{succ}^*(d)$ at their common endpoint $\textsf{head}(d)$, but in fact $\angle c$ can be any real (or complex!) number.  As usual, we measure angles in units of circles (or “turns”), as the gods intended.

We can then define the _combinatorial curvature_ of a face $f$ or a vertex $v$, with respect to this angle assignment, as follows:
$$
	\kappa(f) := 1 - \sum_{c\in f} \angle c
	\qquad\qquad
	\kappa(v) := 1 - \frac{1}{2} \deg(v) + \sum_{c\in v} \angle c
$$
Or more formally, equating corners with darts:
$$
	\kappa(f) := 1 - \sum_{d \colon \textsf{left}(d) = f} \angle d
	\qquad\qquad
	\kappa(v) := 1 - \sum_{d \colon \textsf{head}(d) = v}
							\left(\frac12 - \angle d\right)
$$

For example, suppose every edge of $\Sigma$ is a line segment, and we actually measure corner angles geometrically.  Then every vertex has curvature $0$ (because its interior corner angles sum to one circle) and every _bounded_ face of $\Sigma$ has curvature $0$ (because its total turning angle is $1$).  However, the the _outer_ face is oriented clockwise instead of counterclockwise, so its total turning angle is $-1$, and thus its curvature is $2$.  That $2$ is actually the same as the $2$ in Euler’s formula.

Alternatively, suppose $\Sigma$ is actually embedded on the _unit sphere_, every edge is an arc of a great circle, and angles are again measured geometrically (between tangent vectors).  Then every vertex of $\Sigma$ has curvature zero, because interior angles at any vertex sum to one circle, and a bit of spherical trigonometry implies that every face of $\Sigma$ has curvature equal to its area divided by $2\pi$.  Because the unit sphere has surface area $4\pi$, the sum of all the face curvatures is $2$.  That $2$ is actually the same as the $2$ in Euler’s formula!  (In fact, this is how Lagrange actually proved Euler’s formula for the first time.)


**The Combinatorial Gauss-Bonnet Theorem:**
: _For any planar map $\Sigma = (V, E, F)$ and for **any** assignment of angles to the corners of $\Sigma$, we have $\sum_{v \in V} \kappa(v) + \sum_{f \in F} \kappa(f) = 2$._

**Proof:**
: We immediately have $\sum_f \kappa(f) = |F| - \sum_c \angle c$ and $\sum_v \kappa(f) = |V| - |E| + \sum_c \angle c$, which implies that $\sum_v \kappa(v) + \sum_f \kappa(f) = |V| - |E| + |F| = 2$ by Euler’s formula. $\qquad\square$

As a final geometric example, suppose $\Sigma$ is actually the complex of vertices, edges, and faces of a three-dimensional convex polyhedron (which is homeomorphic to a sphere), and again, angles are measured geometrically.  Each face of $\Sigma$ is a convex planar polygon, and therefore has curvature zero.  The interior angles at each vertex of $\Sigma$ sum to less than a full circle, so every vertex has positive curvature.  The Combinatorial Gauss-Bonnet Theorem implies that the sum of the vertex curvatures is exactly $2$.  In other words, the sum of the _angle defects_ at the vertices is two full circles, or eight right angles.


## Historical Digression

Euler’s formula has a long and convoluted history, involving unpublished and lost manuscripts, quack medicine, boat wrecks, priority battles, bad translations, incorrect proofs, and philosophical arguments over the natural of mathematical proof.  At the risk of adding to the thousands of gallons of ink, seat, and blood that have already been spilled over this history, let me briefly mention a few highlights.

The first known statement of Euler’s formula is in an unpublished manuscript _Compaginationes solidorum regularium_ (Combinations of regular solids) written by Francesco Maurolico between 1536 and 1537.

> _Item manifestum est in unoquoque regularium solidorum, numerum basium coniunctum cum numero cacuminum conflare numerum, qui binario excedit numerum laterum._  [It is obvious that in each of the regular solids, the number of bases (faces) combined with the number of peaks (vertices) is a number that exceeds the number of sides (edges) by 2.]
  
Maurolico only considered the five Platonic solids, for which the formula follows by direct inspection.

René Descartes described the angle defect theorem for convex polyhedra, and derived Euler’s formula from it, in his unpublished note _Progymnasmata de solidorum elementis_ [_Exercises in the Elements of Solids_], written around 1630.

> _Ponam semper pro numero angulorum solidorum $\alpha$ \& pro numero facirum $\varphi\dots$. Numerus verorum angulorum planorum est $2\varphi - 2\alpha - 4$._ [I always write $\alpha$ for the number of solid angles (vertices) and $\varphi$ for the number of faces$\dots$.  The total number of plane angles (corners) is $2\varphi - 2\alpha - 4$.]

It is a matter of surprisingly intense scholarly dispute whether Descartes actually stated Euler’s formula, and therefore deserves to share credit with Euler, or only came close, and therefore does not.  Descartes did not express his formula using the syntax $V-E+F=2$, but in my opinion, this is entirely a matter of notational emphasis, not content or understanding.  Elsewhere in _Progymnasmata_, Descartes observed that the number of plane angles is exactly twice the number of edges, and he used the numbers of vertices, edges, and faces of the Platonic and several Archimedean solids to derive formulas for corresponding figurate numbers. Had Descartes actually published his _Progymnasmata_, I believe even Euler (who exhibited surprise that the formula was not already known) would have called it “Descartes’ formula”.

Descartes traveled to Sweden in 1649 at the invitation of then-19-year-old Queen Christina.  Due to his poor health, Descartes normally slept late, but after a few months, the young queen required Descartes to give her lessons in philosophy three days a week, lasting five hours per day and beginning at 5am.  Within a month, Descartes fell ill.  He refused the treatments offered by the Swedish doctors, preferring his own French doctor’s prescription of tobacco-infused wine to induce vomiting.  The treatment proved ineffective, and Descartes eventually died of pneumonia in February 1650.

After Descartes' death, his possessions were shipped to his friend Claude Clerselier in Paris; upon arrival, a box of manuscripts, including the _Progymnasmata_, fell into the Seine and was not recovered for three days.  Clerselier rescued Descartes' manuscripts, and after carefully drying them, made them available to other scholars.

Gottfried Leibniz transcribed several of Descartes’ manuscripts, including the _Progymnasmata_, during a trip to Paris in 1676, most likely in an effort to collect evidence against recent charges by English mathematicians that his results were merely elaborations of Descartes' ideas.  (Isaac Newton charged Leibniz of plagiarizing his calculus later that same year.)  Descartes' original manuscript was then lost forever.  Leibniz's hand-written copy vanished into his archives until 1859, when it was rediscovered by Louis Alexandre Foucher de Careil in an uncatalogued pile of Leibniz's papers.[^hhgg]  Foucher de Careil published Leibniz's transcription \cite{f-oid-1859}, but his re-transcription introduced several significant errors, rendering it essentially useless.  An accurate transcription of the \emph{Progymnasmata} finally appeared in 1908.<!--, thanks to the combined efforts of several Cartesian and Leibnizian scholars \cite{a-dse-1908}.  The remarkable story is told in more detail by Federico \cite{f-dpsds-82}, Richeson \cite{r-eg-05}, and (with some creative embellishment) Aczel \cite{a-dsn-05}.-->

[^hhgg]: $\dots$ on display in the bottom of a locked filing cabinet stuck in a disused lavatory with a sign on the door saying ‘Beware of the Leonhard’.

Leonhard Euler stated both his eponymous formula and the angle defect theorem for convex polyhedra, expressing surprise that neither was previously known, in a letter to his friend and colleague Christian Goldbach in 1750.  Two years later, he proposed an inductive proof to the St. Petersberg Academy of Sciences; unfortunately his proof was flawed.  Similarly flawed inductive proofs were published by Karsten in 1768, by Meister in 1785, by L'Huillier in 1811, by Cauchy in 1813, and by Grunert in 1827.  One of Cauchy’s inductive arguments is presented in numerous textbooks as the first correct proof of Euler’s formula, but that claim is incorrect for at least three reasons: The argument is not original to Cauchy; the argument is not a proof; and a correct proof was already known.[^four]

[^four]: $\dots$ and the formula isn’t _Euler’s_.

Cauchy argued as follows: Consider a simple planar map $\Sigma$ whose bounded faces are all triangles and whose outer face is a simple cycle.  Let $f$ be any face that has at least one edge on the outer face.  If $f$ shares one edge with the outer face, then deleting that edge removes one edge and one face.  If $f$ shares two edges with the outer face, then removing those two edges removes one vertex, two edges, and one face.  Finally, if all three edges of $f$ are boundary edges, the map has only one bounded face, so $v=e=3$ and $f=2$.  
  
Unfortunately, Cauchy (and his predecessors) did not prove that one can always choose a face $f$ so that the outer boundary is still a simple cycle after $f$ is removed.  This fact is not hard to prove using a second careful induction argument (which I’ll present in the next lecture), but neither Euler, nor Karsten, nor Meister, nor L’Huillier, nor Cauchy, nor Grunert offered such a proof.  Lakatos noticed this lacuna in Cauchy’s argument and proposed a proof, but his proposed proof was flawed.  Most modern presentations of “Cauchy’s” “proof”---including Wikipedia’s---either ignore this subtlety entirely, or merely _state_ that $f$ must be chosen carefully without proving that is always possible.

The first _correct_ proof of Euler’s formula was given by Legendre in 1794.  Legendre projects the vertices and edges of the polyhedron onto the unit sphere from an arbitrary interior point, and then applies the already well-known fact that a spherical triangle with interior angles $\alpha$, $\beta$, and $\gamma$ has area $\alpha+\beta+\gamma-\pi$.  Suppose the original polyhedron has $n$ vertices and $f$ facets, all triangles.  The angles at each vertex of the resulting spherical triangulation sum to exactly $2\pi$; thus, the total area of all $f$ spherical triangles is $2\pi n - \pi f$.  We immediately conclude that $f = 2n-4$, because the surface area of the unit sphere is $4\pi$.  The proof for more general polyhedra follows by triangulating the faces.  <!-- Essentially the same proof was later given by Hirsch in 1807, and   l’Huillier described a similar proof based on Euclidean angles in 1811. -->

The first correct _combinatorial_ proof of Euler’s formula is Von Staudt’s 1847 tree-cotree proof.  Von Staudt’s actual argument is remarkably concise, despite being written in mid-19th-century academic German, especially in comparison to the earlier inductive arguments:

> _Wenn nämlich der Körper $E$ Eckpünkte hat, so sind $E-1$ Kanten, von welchen die erste zwei Eckpunkte unter sich, die zweite einen derselben mit einem dritten, die dritte einen der drei vorigen mit einem vierten u.s.w.\ verbindet, hinreichend um von jedem Eckpunkte auf jeden andern übergehen zu können.  Da nun in einem solchen Systeme von Kanten keine geschlossene Linie enthalten ist, jede der übrigen (noch freien) Kanten aber mit zwei oder mehrern Kanten des Systems eine geschlossene Linie bildet, so sind die übrigen Kanten hinreichend aber auch alle erforderlich, um durch sie von jeder der $F$ Flächen des Korpers auf jede andere übergehen zu können, woraus man scldiessen kann, dass die Anzahl der übrigen Kanten $F-1$, mithin die Anzahl aller Kanten $E+F-2$ und demnach $E+F=K+2$ sey._

> [When a body has $n$ vertices, then $n-1$ edges are sufficient---the first connecting two vertices, the second connecting one of those with a third, the third connecting one of the three rpevious vertices with a fourth, and so on---to be able to go from any vertex to any other.  Such a system of edges does not contain a closed line, but each of the remaining edges forms a closed line with two or more edges of the system, so the remaining edges are sufficient, but also necessary, to be able to go through them from any of the $f$ faces of the body to any other.  It follows that the number of remaining edges if $f-1$; hence the number of all edges is $n+f-2$, and therefore $n+f=m+2$.]

> [More loosely: When a body has $n$ vertices, we can find $n-1$ edges that define a spanning tree $T$.  Cutting the surface along every edge in $T$ leaves the surface connected, but additionally cutting any other edge disconnects the surface, so that edges not in $T$ are just enough to keep the faces of the body connected.  It follows that the number of remaining edges if $f-1$, so the total number of edges is $n+f-2$.]

All of these proofs were intended to prove Euler’s formula _for convex polyhedra_, although Cauchy’s proof starts by projecting the polyhedron to a _straight-line_ planar map.  The first proofs that directly consider planar maps are due to Cayley and Listing, both published in 1861.  <!-- In fact, both Cayley and Listing allowed their graphs to include isolated closed “edges” with no vertices, and Listing considered much more general “acyclodic spatial complexes” constructed by gluing disks to cycles in graphs.-->  Cayley's argument is a prototype for our first inductive proof; he observed that the quantity $n-m+f$ does not change when one inserts a new vertex in the interior of an edge or inserts a new edge in the interior of a face.  Listing repeats (and generalizes) Cauchy's argument, using a global counting argument instead of induction, but again assuming without proof the existence of a shelling order.  Both proofs implicitly assume the Jordan curve theorem, so even ignoring shelling issues, they technically only apply to _combinatorial_ maps.


## Aptly Named

* Outerplanar graphs/maps

* Easy consequences of Euler’s formula:
	* Every simple planar graph has a vertex of degree at most $5$.
	* Every planar triangulation has $3n-6$ edges and $2n-4$ faces.
	* Every simple planar graph has at most $3n-6$ edges.
	* Every simple planar bipartite graph has at most $2n-4$ edges.
	* Every planar map has either a vertex or a face of degree at most $3$.
	* $K_{3,3}$ and $K_5$ are not planar.
	* There are only five Platonic solids.
	* Every loop-free planar graph is 6-colorable.
	* Every planar graph has an independent set of size $\Omega(n)$ in which every vertex has degree $O(1)$.

* Minimum spanning trees:
	* Tarjan’s red-blue meta-algorithm
	* Borůvka’s algorithm
	* Mareš’s algorithm, Matsui’s algorithm
	* minimum spanning tree $\leftrightharpoons$ maximum spanning cotree

* Equivalence of tree-cotree decompositions and tree-onion figures

* Random (but not uniform!) rooted planar maps via random tree-onion figures
