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
    \setcounter{section}{18}
---

# Surface Maps$^\beta$

Recall that a _planar map_ is the decomposition of the plane (or by standard abuse of terminology, the sphere) induces by an embedding of a graph in the plane.  Any planar map can be represented by a _rotation system_ $\Sigma = (D, \textsf{rev}, \textsf{succ})$ where $D$ is the set of darts of the embedded graph, $\textsf{rev}$ is the reversal involution for those darts, and $\textsf{succ}$ is a permutation of the darts whose orbits describe the darts into each vertex of the embedded graph in clockwise order.  The orbits of the permutation $\textsf{rev}(\textsf{succ})$ describe the counterclockwise order of darts around the boundary of each face.  A rotation system with $n$ vertices, $m$ edges, and $f$ faces is _planar_ if and only if $n-m+f = 2$.

But what if $n-m+f \ne 2$?  In that case, $\Sigma$ represents a map on a more complex surface.

## Surfaces, Polygonal Schemata, and Cellular Embeddings

A _surface_ (or _2-manifold_) is a (compact, second-countable, Hausdorff) topological space that is _locally homeomorphic_ to the plane.  That is, every point lies in an open subset of the space that is homeomorphic to $\mathbb{R}^2$.  (Later we will also consider _surfaces with boundary_, spaces where every point lies in an open neighborhood homeomorphic to either the plane or a closed halfplane.)

The simplest method to construct surfaces is to glue disks together along their boundary segments.  A _polygonal schema_ is a finite set of polygons with labeled edges, where each label appears exactly twice.  We can construct a surface by identifying every pair of edges with the same label; specifically, if the edges of each polygon are oriented counterclockwise around its interior, we identify each edge with the _reversal_ of the other edge with the same label.  The vertices and edges of the polygons become the vertices and edges of a graph; the interiors of the polygons become the faces of the resulting embedding.

Formally, an (abstract) polygonal schema is a triple $(D, \textsf{rev}, \textsf{succ}^*)$, where $D$ is a set of darts (representing the sides of the polygons), \textsf{rev} is an involution of those darts (representing pairs of sides with matching labels), and $\textsf{succ}^*$ is a permutation describing the counterclockwise order of darts around each face/polygon.  Hopefully it’s clear that “abstract polygonal schema” is just a synonym for “dual rotation system”.

To transform an abstract polygonal schema $\Pi$ into a topological space, let $F$ denote a set of disjoint closed disks in the plane, one for each orbit of $\textsf{succ}^*$.  For each orbit of length $d$, we subdivide the counterclockwise boundary of the corresponding disk into $d$ paths.  We identify those paths with the darts, so that $\textsf{succ}^*(d)(0) = d(1)$ for every dart/path $d$.  Then the space $\mathcal{S}(\Pi)$ is the quotient space $\bigsqcup F / \sim$, where $d(t) \sim \textsf{rev}(d)(1-t)$ for every dart/path $d$ and $t\in[0,1]$.  In other words, we identify each dart with the reversal of its reversal!  It is not hard to verify that the space $\mathcal{S}(\Pi)$ is always a 2-manifold; the vertices, edges, and faces constitute a map $\Sigma(\Pi)$ of this surface.[^trivial]

[^trivial]: This construction breaks down when $D = \varnothing$; in this case, the space $\mathcal{S}(\Pi)$ is the sphere and $\Sigma(\Pi)$ is the trivial map with one vertex, one face, and no edges.

Moving in the other direction, recall that an _embedding_ of a graph $G = (V, \textsf{rev}, \textsf{head})$ on a surface $\mathcal{S}$ is a continuous injective function from $G$ (as a topological graph) into $\mathcal{S}$.  The components of the complement of the image of the embedding are the _faces_ of the embedding.  An embedding is _cellular_ if every face is homeomorphic to an open disk.  The vertices, edges, and faces of an embedding define a surface map if and only if the embedding is cellular; in particular, the embedded graph must be connected.

## Orientability 

Any discussion of rotation systems or polygonal schemata for surface maps assumes _a priori_ that the underlying surface is _orientable_, meaning it is possible to consistently define “clockwise” and “counterclockwise” everyone on the surface.  As we’ll prove in the next lecture, every orientable surface can be constructed from the sphere by attaching one or more “handles”; the number of handles is called the _genus_ of the surface.  More formally, the genus of a surface $\mathcal{S}$ is the maximum number of closed curves $\gamma_1, \dots, \gamma_g$ in $\mathcal{S}$ whose complement $\mathcal{S} \setminus (\gamma_1 \cup \cdots \cup \gamma_g)$ is connected.

However, not all 2-manifolds are orientable.  The simplest example of a non-orientable surface (with boundary) is the _Möbius band_, which can be constructed from a strip of paper by gluing opposite ends with a half-twist.  More formally, the Möbius band is the quotient space $[0,1]^2 / \sim$ where $(0, t) \sim (1, 1-t)$ for all $t\in[0,1]$.  In fact, Möbius bands are the _only_ obstruction to orientability; a surface  is orientable if and only if it does not contain (a subspace homeomorphic to) a Möbius band.

In one of Lewis Carroll’s lesser-known works, one character explains to another how to sew three square handkerchiefs into “Fortunatus’s Purse” (so called because “Whatever is _inside_ that Purse, is _outside_ it; and whatever is _outside_ it, is _inside_ it. So you have all the wealth of the world in that leetle Purse!”).  His instructions can be interpreted as a signed polygonal schema for a non-orientable surface map of genus 1.

![Mein Herr’s instructions for sewing Fortunatus’s Purse.  Sewing the first two squares along edges $a$ and $b$ yields a Möbius band; so does sewing the last two squares along $f$ and $d$, or sewing the first and last square along $c$ and $e$.](Fig/fortunatus-purse){ width=60% }

![Another signed polygonal schema for Fortunatus’s Purse.](Fig/fortunatus-purse-2){ width=30% }

We can’t represent non-orientable surface maps using rotation systems, so we need a different combinatorial representation.  It is possible to define signed versions of both rotation systems and polygonal schemata, but their navigation requires awkward bookkeeping and case analysis.  Instead we consider a more elegant but slightly more verbose combinatorial representation that works for both orientable and non-orientable surfaces.

## Band Decompositions

Let $\Sigma = (V, E, F)$ be an arbitrary map of some surface $\mathcal{S}$, which may or may not be orientable.  We construct a related surface map $\Sigma^\square$, called a _band decomposition_, intuitively by shrinking each face of $\Sigma$ slightly, expanding each vertex of $\Sigma$ into a small closed disk, and replacing each edge of $\Sigma$ with a closed quadrilateral “band”.

* Each vertex of  $\Sigma^\square$ correspond to a _blade_ in $\Sigma$, which is an edge with a chosen direction (specifying its head) and an _independent_ orientation (specifying its “left” shore).
* There are three types of edges in $\Sigma^\square$, corresponding to the sides, corners, and darts of $\Sigma$.
* There are three types of faces in $\Sigma^\square$, corresponding to the vertices, edges, and faces of $\Sigma$.
* Every vertex of $\Sigma^\square$ is incident to exactly one edge and one face of each type.

If a surface map $\Sigma$ has $n$ vertices, $m$ edges, and $f$ faces, then its band decomposition $\Sigma^\square$ has $4m$ vertices, $6m$ edges ($2m$ of each type), and $n+m+f$ faces.

![A band decomposition (black) of a surface map (white).](Fig/derived-maps/band){ width=40% }

**Lemma:**
_A surface map $\Sigma$ is orientable if and only if the graph of its band decomposition $\Sigma^\square$ is bipartite._

## Reflection Systems

Band decompositions immediately suggest the following combinatorial representation of surface maps.  A _reflection system_.[^ref] is a quadruple $\Xi = (\Phi, a, b, c)$ with the following components:

[^ref]: The term “reflection system” is non-standard, but I think it’s both sufficiently evocative and sufficiently similar to “rotation system” to justify its use.  Reflection systems are also called _graph-encoded maps_ or _graph-encoded manifolds_ or _gems_ (Lins 1983), but the most common term seems to be “combinatorial map” (or just “map”).  Yeah.

* $\Phi$ is a finite set of abstract objects called _blades_ or _flags_.
* $a\colon \Phi\to\Phi$ is an involution of $\Phi$, whose orbits are called _sides_.
* $b\colon \Phi\to\Phi$ is an involution of $\Phi$, whose orbits are called _corners_.
* $c\colon \Phi\to\Phi$ is an involution of $\Phi$, whose orbits are called _darts_.
* The involutions $a$ and $c$ commute, and their product $ac = ca$ is an involution

To simplify notation, I’ll use concatenation to denote compositions of the involutions $a$, $b$, and $c$; thus, for example, $ac$ is shorthand for the permutation $a \circ c$, and $abc(\phi)$ is shorthand for $a(b(c(\phi)))$.

Each blade in $\Sigma$ can be associated with a triple $(v, e, f)$, where $e$ is an edge of $\Sigma$, $v$ is one of $e$’s endpoints, and $f$ is one of $e$’s shores.  Intuitively, each of the involutions $a$, $b$, $c$, changes one of the components of this triple: $a$ changes the vertex (or _apex_); $b$ changes the edge (or _border_); $c$ changes the face (of _chamber_). More formally, the orbits of the permutation group $\langle b,c \rangle$ are the _vertices_ of the reflection system; the orbits of $\langle a,c \rangle$ are its _edges_; and the orbits of $\langle a,b \rangle$ are its _faces_. 

![Operations on blades in a reflection system.](Fig/blade-operations){ width=70% }

Every reflection system represents a unique surface map with corresponding blades, sides, corners, darts, vertices, edges, and faces. (In particular, the trivial reflection system with $\Phi = \varnothing$ represents the trivial map.)  Conversely, every surface map is represented by a _unique_ reflection system.

![Corresponding vertices and edges in the band decomposition.](Fig/reflection-band){ width=40% }

Just as rotation systems are mathematical abstractions of incidence lists, reflection systems can also be encoded as a simple data structure for surface maps, which has one record for every blade $\phi$, each containing the index of its head and pointers to its neighboring blades $a(\phi)$, $b(\phi)$, $c(\phi)$, along with an array indexed by vertices pointing to an arbitrary blade into each vertex.  (It may also be convenient to store the index of each blade’s “left” shore, and a face-indexed array pointing one blade for each face.)

A particularly simple implementation represents blades by integers from $0$ to $4m-1$, such that for any blade $\phi$, the neighboring blades $a(\phi)$ and $c(\phi)$ are  obtained by flipping the two least significant bits, for example, by defining $a(\phi) = \phi\oplus 2$ and $c(\phi) = \phi\oplus 1$.  Thus, edge $e$ consists of blades $4e, 4e+1, 4e+2, 4e+3$, and blade $\phi$ belongs to edge $\lfloor \phi/4 \rfloor$.  Then any static surface map can be represented using five arrays:

* $\textsf{vany}[0\,..\,n]$ storing an arbitrary blade for each vertex;
* $\textsf{fany}[0\,..\,f]$ storing an arbitrary blade for each face;
* $\textsf{vert}[0\,..\,4m-1]$ storing the “head” vertex of each blade;
* $\textsf{face}[0\,..\,4m-1]$ storing the “left” face of each blade;
* $B[0\,..\,4m-1]$ storing the involution $b$.

Notice that $\textsf{vert}(\phi) = \textsf{vert}(c(\phi)) = \textsf{vert}(\phi\oplus 1)$ and $\textsf{face}(\phi) = \textsf{face}(a(\phi)) = \textsf{face}(\phi\oplus 2)$, so in principle, exactly half of the $\textsf{vert}$ and $\textsf{face}$ arrays are redundant.

![A reflection system for Fortunatus’s Purse.](Fig/fortunatus-purse-band){ width=30% }

## Equivalence 

Transforming a rotation system of a surface map into an equivalent reflection system or vice versa (if the map is orientable) is straightforward.

Let $\Sigma = (D, \textsf{rev}, \textsf{succ})$ be a rotation system.  Then setting $\Phi := D\times \{-1, +1\}$ and defining the involutions as follows gives us an equivalent reflection system:
$$
	\begin{aligned}
		a((d, +1)) & := (\textsf{rev}(d), -1) 
		&
		a((d, -1)) & := (\textsf{rev}(d), +1) 
		\\
		b((d, +1)) & := (\textsf{succ}(d), -1) 
		&
		b((d, -1)) & := (\textsf{succ}^{-1}(d), +1)
		\\
		c((d, +1)) & := (d, -1)
		&
		c((d, -1)) & := (d, +1)
	\end{aligned}
$$

Conversely, let $\Xi = (\Phi, a, b, c)$ be an orientable reflection system.  Because $\Xi$ is orientable, we can partition $\Phi$ into two subsets $\Phi^+$ and $\Phi^-$, so that each of the involutions $a,b,c$ is a bijection between the two subsets.  We can construct a rotation system equivalent to $\Xi$ by setting $D := \Phi^+$ and $\textsf{rev} := a\circ c$ and $\textsf{succ} := b\circ c$.


## Duality

Duality generalizes naturally from planar maps to surface maps.  Two surface maps $\Sigma$ and $\Sigma^*$ of the same underlying surface are _duals_ if (up to homeomorphism) each face of $\Sigma$ contains exactly one vertex of $\Sigma^*$, each face of $\Sigma^*$ contains exactly one vertex of $\Sigma$, and each edge of $\Sigma$ crosses exactly one edge of $\Sigma^*$.

Just as in the planar setting, the dual of a rotation system $\Sigma = (D, \textsf{rev}, \textsf{succ})$ is obtained by replacing the successor permutation $\textsf{succ}$ with $\textsf{succ}^* :=  \textsf{rev}(\textsf{succ})$; that is, $\Sigma^* = (D, \textsf{rev}, \textsf{rev}(\textsf{succ}))$.  Thus, the darts in any _orientable_ surface map $\Sigma$ are dual to (or more formally, _are_) the darts in the dual map $\Sigma^*$.

Duality for reflection systems is similarly straightforward.  Suppose $\Xi = (\Phi, a, b, c)$ is the reflection system for a surface map $\Sigma$; exchanging the involutions $a$ and $c$, gives us the dual reflection system $\Xi^* = (\Phi, c, b, a)$, which is the reflection system of its dual map $\Sigma^*$.  (As a mnemonic device, we could refer to the vertices, edges, and faces of the dual map $\Sigma^*$ as _areas_, _borders_, and _centroids_, respectively.)  In this representation, darts in a surface map are dual to (or more formally, _are_) _sides_ in its dual map, rather than darts.  

**Lemma:**
: _Every surface map $\Sigma$ and its dual $\Sigma^*$ have the same band decomposition: $\Sigma^\square = (\Sigma^*)^\square$._

For _orientable_ surface maps, we have exactly the same correspondences between features in primal and dual rotation systems as we do for planar maps.

| Primal $\Sigma$	| Dual $\Sigma^*$	| Primal $\Sigma$	| Dual $\Sigma^*$	|
| :--------------:	| :---------------:	| :--------------:	| :---------------:	|
| vertex $v$		| face $v^*$		| $\textsf{head}(d)$	| $\textsf{left}(d^*)$	|
| dart $d$			| dart $d^*$		| $\textsf{tail}(d)$	| $\textsf{right}(d^*)$	|
| edge $e$			| edge $e^*$		| $\textsf{left}(d)$	| $\textsf{head}(d^*)$	|
| face $f$			| vertex $f^*$		| $\textsf{right}(d)$	| $\textsf{tail}(d^*)$	|
| $\textsf{succ}$	| $\textsf{rev}\circ\textsf{succ}$ | clockwise	| counterclockwise	|
| $\textsf{rev}$	| $\textsf{rev}$	|	 	|		| 

: A (partial) duality dictionary for rotation systems of orientable surface maps

There is a similar but slightly more complex correspondence between primal and dual _reflection_ systems.  In particular, the dual of a _directed_ map (where every edge has a preferred “head” vertex) on a non-orientable surface is not another directed graph, but rather an _sided_ map (where every edge has a preferred _face_).

| Primal $\Sigma$	| Dual $\Sigma^*$	| Primal $\Sigma$	| Dual $\Sigma^*$	|
| :--------------:	| :---------------:	| :--------------:	| :---------------:	|
| vertex $v$		| face $v^*$		| $a$				| $c$				|
| blade $\phi$		| blade $\phi^*$	| $b$				| $b$				|
| dart $d$			| side $d^*$		| $c$				| $a$				|
| side $\sigma$		| dart $\sigma^*$	| $\textsf{vert}(\phi)$	| $\textsf{face}(\phi^*)$	|
| edge $e$			| edge $e^*$		| $\textsf{face}(\phi)$	| $\textsf{vert}(\phi^*)$	|
| face $f$			| vertex $f^*$		| 

: A (partial) duality dictionary for reflection systems 


## Loops and Isthmuses; Deletion and Contraction

Recall that a _loop_ in a graph is an edge that is incident to only one vertex, and a _bridge_ is an edge whose deletion disconnects the graph.  An _isthmus_ in a surface map is an edge that is incident to only one face.  As in planar maps, every bridge in a surface map is also an isthmus.  The Jordan curve theorem implies that every isthmus in a _planar_ map is also a bridge, but because the Jordan curve theorem does not extend to maps on other surfaces, an an isthmus in a surface map is _not_ necessarily a bridge.  Moreover, unlike in planar graphs, the same edge in a surface map can be _both_ a loop _and_ an isthmus.

Let $\Sigma = (V, E, F)$ be an arbitrary surface map.  Deleting any edge $e$ that is not an isthmus yields a simpler map $\Sigma\setminus e$ _of the same surface_ with the same vertices, one less edge, and with the two faces on either side of $e$ replaces with their union.  Similarly, contracting any edge $e$ that is not a loop yields a simpler map $\Sigma / e$ _of the same surface_  with the endpoints of $e$ merged into a single vertex, one less edge, and the same number of faces.

Contraction and deletion modify the rotation system of an orientable surface map exactly as they do in planar maps:
$$
	(\textsf{succ}\setminus e)(d) = \begin{cases}
		\textsf{succ}(\textsf{succ}(\textsf{succ}(d)))
		\hphantom{^{**}}
			& \text{if $\textsf{succ}(d) \in e$ and
						$\textsf{succ}(\textsf{succ}(d)) \in e$,}\\
		\textsf{succ}(\textsf{succ}(d))
			& \text{if $\textsf{succ}(d) \in e$,}\\
		\textsf{succ}(d) & \text{otherwise.}
	\end{cases}
$$
$$
	(\textsf{succ} \mathbin/ e)(d) = \begin{cases}
		\textsf{succ}(\textsf{succ}^*(\textsf{succ}^*(d)))
			& \text{if $\textsf{succ}(d) \in e$ and
						$\textsf{succ}^*(\textsf{succ}(d)) \in e$,}\\
		\textsf{succ}(\textsf{succ}^*(d))
			& \text{if $\textsf{succ}(d) \in e$,}\\
		\textsf{succ}(d) & \text{otherwise.}
	\end{cases}
$$
The first deletion case occurs when the deleted edge is an empty loop; the first contraction case occurs when one endpoint of the contracted edge is a _leaf_ (has degree $1$).

Deletion and contraction can be similarly implemented in reflection systems, even in non-orientable maps.  If we equate $e$ with the corresponding set of four flags in $\Phi$, then the reflection systems $\Xi\setminus e = (\Phi\setminus e, a, b\setminus e, c)$ and $\Xi\mathbin/ e = (\Phi\setminus e, a, b\mathbin/ e, c)$, which respectively represent the maps $\Sigma\setminus e$ and $\Sigma\mathbin/ e$, can be defined as follows, for all $\phi \in \Phi\setminus e$:
$$
	(b\setminus e)(\phi) := 
	\begin{cases}
		\mathit{b c b c b}(\phi)\quad{}
					& \text{if~ $b(\phi) \in e$
							~and~ $\mathit{b c b}(\phi) \in e$} \\
		\mathit{b c b}(\phi)
					& \text{if~ $b(\phi) \in e$} \\
		b(\phi) 		& \text{otherwise}
	\end{cases}
$$
$$
	(b\mathbin/ e)(\phi) := 
	\begin{cases}
		\mathit{babab}(\phi)\quad{}
					& \text{if~ $b(\phi) \in e$
						~and~ $\mathit{bab}(\phi) \in e$} \\
		\mathit{bab}(\phi)
					& \text{if~ $b(\phi) \in e$} \\
		b(\phi)	& \text{otherwise}
	\end{cases}
$$
Again, the complicated first cases correspond to the only edge incident to a vertex or an edge.  We emphasize the involutions $a$ and $c$ from the original reflection system $\Xi$ appear verbatim (except for their smaller domains) in $\Xi\setminus e$ and $\Xi\mathbin/ e$.

![Typical contraction, expansion, deletion, and insertion in the band decomposition.](Fig/band-delete-contract){ width=80% }

![Deleting or inserting an empty loop.](Fig/band-delete-loop){ width=65% }

![Contracting or expanding a leaf.](Fig/band-contract-leaf){ width=65% }

![Deleting or contracting a twisted loop/isthmus.](Fig/band-delete-twist){ width=65% }

## References

1. Lewis Carroll. [_Sylvie and Bruno Concluded_](https://www.gutenberg.org/ebooks/48795).  Illustrated by Henry Furniss.  Macmillan and Co., 1893.

1. Sóstenes Lins.
[Graph-encoded maps](http://doi.org/10.1016/0095-8956(82)90033-8).
_J. Comb. Theory Ser. B_ 32:171–181, 1982.




## Sir Not Appearing

- Henry Slade and the “Afghan Bands”


![Mein Herr explains to Lady Muriel how to sew Fortunatus’ Purse.](Fig/MeinHerr){ width=60% }
