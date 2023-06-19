---
numbersections: true
fontsize: 11pt
geometry:
- hmargin=1.25in
- vmargin=1in
header-includes: |
    \usepackage[charter]{mathdesign}
    \usepackage{inconsolata,sourcesanspro,stmaryrd,eucal}
    \usepackage[font={footnotesize,sf},labelfont=bf]{caption}
    \setcounter{section}{1}
---

# Winding Numbers$^\beta$

## Let me not be pent up, sir; I will fast, being loose.

_Fast and Loose_ is the name of a family of magic tricks (or con games) performed with ropes, chains, and belts that have been practiced since at least the 14th century; the con game is mentioned in three different Shakespeare plays.  In one such trick, now sometimes called the _Endless Chain_, the con artist arranges a closed loop of chain into a doubled figure-8, and then asks the mark to put their finger on the table inside one of the loops.  The con artist them pulls the chain along the table.  If the chain catches on the mark's finger, then the chain is _fast_ and the mark wins; if the con artist can pull the chain completely off the table, the chain is _loose_ and the mark loses.

The con artist shows the mark that there are two different ways for the loops to fall.  (Notice how the chain crosses itself in the lower corners.)  Because the chain is bright and shiny and bumpy, it's impossible for the mark to tell which way the chain is actually arranged, but because these are the only possibilities, the mark should have a 50-50 chance of winning.  Right?  _Riiiight?_

![Two arrangements of the Endless Chain](Fig/fast-and-loose){ width=65% }

Oh, you sweet summer child.  Of course not!  As soon as the mark places money _on the barrelhead_, the con artist wins every time.  The con artists was lying; there is a third arrangement of the chain that is _always_ loose, no matter where the mark puts their finger.[^garter]

[^garter]: There is another completely different “Fast and Loose” con game, also known as called “Pricking the Garter”, that’s usually performed with a belt.  It’s less self-working, less mathematically interesting (despite _seeming_ to invoke the Jordan curve theorem) , and less _shiny_ than the Endless Chain.

![The actual arrangement of the Endless Chain](Fig/fast-and-loose-cheat){ width=30% }


## Shoelaces and Signed Areas

***Swap this section and next?  This is historical order, but the narrative is a bit clunky.***

Before discussing the mathematical reasons you just lost all your money, let’s consider a basic computational geometry problem: How quickly can we compute the area enclosed by a given polygon $P$?

A particularly simple algorithm was described by Albrecht Meister in 1785.  In principle, we can calculate the area of $P$ by cutting $P$ into disjoint triangles and then summing the triangle areas, each of which can can compute in $O(1)$ time, but it would be more than a century before anyone knew how to cut polygons into triangles.  Meister’s insight was to consider the _signed_ areas of _overlapping_ oriented triangles.

The signed area of a triangle depends not only on its vertex coordinates, but on the orientation of its three vertices.  By convention, counterclockwise triangles have positive signed area, and clockwise triangles have negative signed area.  Recall that a triple of points $(q,r,s)$ is oriented counterclockwise or clockwise if and only if the following determinant is positive or negative, respectively:
$$
	\Delta(q,r,s) = 
	\det
	\begin{bmatrix}
		1 & q.x & q.y \\
		1 & r.x & r.y \\
		1 & s.x & s.y
	\end{bmatrix}
	= (r.x - q.x)(s.y - q.y) - (r.y - q.y)(s.x - q.x).
$$
The _signed area_ of the triangle $\triangle qrs$ is $\frac{1}{2} \Delta(q,r,s)$.

Let $o$ be an _arbitrary_ point in the plane.  Meister observed that the _signed_ area of any _oriented_ polygon $P$ is the sum of the signed areas of the triangles determined by $o$ and the edges of $P$:
$$
	\textsf{area}(P) = 
	\frac{1}{2}
		\sum_{i=0}^{n-1}
		\Delta(o, p_i, p_{i+1})
$$
(To simplify notation, I’ll omit “${}\bmod n$” from all index arithmetic.)  In particular, if we take $o$ to be the origin $(0,0)$, we have 
$$
	\textsf{area}(P)
	~=~ 
	\frac{1}{2}
		\sum_{i=0}^{n-1}
		(x_i \cdot y_{i+1} - y_i \cdot x_{i+1})
	~=~
	\frac{1}{2}
		\sum_{i=0}^{n-1}
		\det
			\begin{bmatrix}
				x_i & y_i \\
				x_{i+1} & y_{i+1} \\
			\end{bmatrix}
$$
where $p_i = (x_i,y_i)$ for each index $i$.  This expression of Meister’s algorithm is commonly known as the _shoelace formula_, because the pattern of multiplications resembles the usual method for threading shoelaces:
$$
	\begin{bmatrix}
		x_0 && x_1 && x_2 && x_3 && \dots  \\[-1ex]
		&\times& &\times& &\times& &\times& \\[-1ex]
		y_0 && y_1 && y_2 && y_3 && \dots
	\end{bmatrix}
$$

Proving that that the shoelace algorithm correctly computes areas is straightforward.  First, we can prove that the formula is correct for _triangles_, either by verifying[^cofactor] the algebraic identity
$$
	\Delta(q,r,s) = \Delta(o,q,r) + \Delta(o,r,s) + \Delta(o,s,q)
$$
or by geometric case analysis, as suggested by the figure below.  Areas outside the triangle are either counted once positively and once negatively, or not counted at all; areas inside the triangle are counted exactly once, with the correct sign. 

[^cofactor]: Hint: cofactor expansion

![Lacing a triangle: Add the green (counterclockwise) triangles and subtract the pink (clockwise) triangles.](Fig/shoelace-triangles){ width=75% }

Then to prove the shoelace formula correct for any larger polygon $P$, we can sum the signed areas of all triangles in any frugal triangulation of $P$ and observe that the terms involving diagonals of the triangulation cancel out.  As expected, the resulting signed area is positive if $P$ is oriented counterclockwise (that is, with the interior on the left) and negative if $P$ is oriented clockwise.

Meister actually used his shoelace formula to define the signed areas of an _arbitrary_ polygon, even if that polygon is not simple.  Here it’s somewhat less clear that the formula is _correct_ for non-convex polygons, but we can verify two facts that suggest that it is at least _sensible_.  First, the resulting signed area is still independent of the choice of point $o$.  Second, the formula counts the area of each component of $\mathbb{R}^2\setminus P$ some integer number of times; in particular, the (infinite) area of the unbounded region is not counted at all.  The resulting assignment of integers to the  components of $\mathbb{R}^2\setminus P$ is called the _Alexander numbering_ of $P$.

![Computing the signed area of a polygon, from Meister (1785)](Fig/Meister-nonsimple-polygon){ width=30% }

![One positive triangle and one negative triangle for Meister’s polygon](Fig/Meister-polygon-shoelace){ width=30% }

![The Alexander numbering of Meister’s polygon](Fig/Meister-polygon-winding){ width=30% }

![Another Alexander numbering, from Möbius (1865)](Fig/Mobius-Alexander-Numbering){ width=30% }

## Winding numbers

The _winding number_ of a polygon $P$ around a point $o$ is intuitively (and not surprisingly) the number of times that $P$ winds counterclockwise around $o$.  For example, if $P$ is a _simple_ polygon, its winding number around any exterior point is zero, and its winding number around any interior point is either $+1$ or $-1$, depending on how the polygon is oriented.  If the polygon winds _clockwise_ around $o$, the winding number is negative.  Crucially, the winding number is only well defined if the polygon does not _contain_ the point $o$.

We can define the winding number more formally as follows.  Let $p_0, p_1, \dots, p_{n-1}$ denote the vertices of $P$ in order.  For each index $i$, let $\theta_i$ denote the interior angle at $o$ in the triangle $\triangle p_i o p_{i+1}$, with positive sign if $(o, p_i, p_{i+1})$ is oriented counterclockwise, and with negative sign if $(o, p_i, p_{i+1})$ is oriented clockwise.  Assuming angles are measured in _circles_,[^circles] the winding number of $P$ around $o$ is the sum $\sum_i \theta_i$.  

[^circles]: This is, of course, the only _correct_ way to measure angles, as opposed to radians or degrees or some other heresy. 

![Winding number as a sum of angles, after Meister](Fig/winding-number){ width=40% }

Actually computing the winding number according to this definition requires inverse trigonometric functions, square roots, and other numerical madness.  Fortunately, there is an equivalent definition that builds on our ray-shooting test from the previous lecture.  Let $R$ be a vertical ray shooting upward from $o$.  We distinguish two types of crossings between the $R$ and the polygon, depending on the orientation of the crossed edges.  Specifically, if the crossed edge is directed from right to left, we have a _positive_ crossing; otherwise, we have a _negative_ crossing.  Equivalently, when $R$ crosses an edge $p_ip_{i+1}$, the sign of the crossing is the sign of the determinant $\Delta(o, p_i, p_{i+1})$.

![A positive crossing (left) and a negative crossing (right)](Fig/ray-crossings){ width=50% }

I’ll leave the equivalence of these two definitions as an exercise.  (Hint: prove equivalence for triangles, and then look at Meister’s figure again!)

Here is the ray-shooting algorithm in (pseudo)Python.  Any similarities with the point-in-polygon algorithm from the previous lecture are purely intentional.

```
def windingNumber(P, o):
	wind = 0
	n = size(P)
	for i in range(n):
		p = P[i]
		q = P[(i+1)%n]
		Delta = (p.x - o.x)*(q.y - o.y) - (p.y - o.y)*(q.x - o.x)
		if p.x <= o.x < q.x && Delta > 0:
			wind += 1
		elif q.x <= o.x < p.x && Delta < 0:
			wind -= 1
	return wind
```

Winding numbers has a third useful interpretation, which we’ve already seen in this lecture.  Case analysis similar to our proof of Lemma $\le 2$ from the previous lecture implies that if $o$ and $o’$ are two points in the same component of $\mathbb{R}^2\setminus P$, then $P$ has the same winding number around both points.  Moreover, if $o$ and $o’$ are in components of $\mathbb{R}^2\setminus P$ that share a segment of some polygon edge $e$ on their boundary, then the winding numbers around $o$ and $o’$ differ by $1$, with the higher winding number to the left of $e$.

This assignment of winding numbers to the components of $\mathbb{R}^2\setminus P$ is identical to the Alexander numbering of $P$ that we defined earlier.  That is, the winding number of $P$ around any point $q \not\in P$ is precisely the number of times that the area around $q$ is counted by the shoelace formula.  Thus, the signed area of any polygon $P$ can expressed in terms of winding numbers as 
$$
	\textsf{area}(P) = \sum_c \textsf{wind}(P, c) \cdot \textsf{area}(c)
$$
where the sum is over the components of $\mathbb{R}^2\setminus P$.

![Another non-simple polygon from Meister, with winding numbers indicated by shading (1785)](Fig/Meister-winding){ width=40% }


## Homotopy

Now let’s go back to the Endless Chain.  A bit of case analysis should convince you—or should at least _strongly suggest_—that in all three configurations, the chain is loose around your finger if and only if the winding number of the Chain around your finger is zero.

![Winding numbers of the Endless Chain around various points](Fig/fast-and-loose-winding){ width=95% }

But in the actual game, we aren’t dealing with a single fixed closed curve.  The con man grabs one side of the chain and pulls, causing the chain to move continuously across the barrelhead and around your finger, until it either gets stuck Fast or pulls Loose.  Instead of thinking about how a fixed polygon wraps with a changing point, we need a way to reason about how a _continuously changing_ curve wraps around a _fixed_ point.

A _homotopy_ between two closed curves is a continuous deformation---a morph---from one curve to the other.  Homotopies can be defined between curves in any topological space, but for purposes of illustration, let’s restrict ourselves to curves in the punctured plane $\mathbb{R}^2\setminus o$, where $o$ is an arbitrary point called the _obstacle_.  (In Fast and Loose, the obstacle is your finger.)  Without loss of generality, I will assume that $o$ is actually the origin $(0,0)$.

Formally, a _homotopy_ between two closed curves in $\mathbb{R}^2\setminus o$ is a continuous function $h\colon [0,1]\times S^1\to \mathbb{R}^2\setminus o$, such that $h(0, \cdot)$ and $h(1, \cdot)$ are the initial and final closed curves, respectively.  For each $0<t<1$, the function $h(t, \cdot)$ is the intermediate closed curve at “time” $t$.  Crucially, none of these intermediate curves touches the obstacle point $o$.

Two closed curves in $\mathbb{R}^2\setminus o$ are _homotopic_, or in the same _homotopy class_, if there is a homotopy from one to the other in $\mathbb{R}^2\setminus o$.  Homotopy is an equivalence relation.

A closed curve is _contractible_ in $\mathbb{R}^2\setminus o$ if it is homotopic to a single point (or more formally, to a constant curve).

<!--
We also need a definition of homotopy between _paths_; this is a little more subtle.  Let $\pi\colon [0,1]\to \mathbb{R}^2\setminus o$ and $\sigma\colon[0,1]\to \mathbb{R}^2\setminus o$ be two paths in the punctured plane with the same endpoints: $\pi(0)=\sigma(0)$ and $\pi(1)=\sigma(1)$.  A _path homotopy_ from $\pi$ to $\sigma$ is a continuous function $h\colon [0,1]\times[0,1]\to \mathbb{R}^2\setminus o$ that satisfies four conditions:

* $H(0, t) = \pi(t)$ for all $t$
* $H(1, t) = \sigma(t)$ for all $t$
* $H(s, 0) = \pi(0) = \sigma(0)$ for all $s$
* $H(s, 1) = \pi(1) = \sigma(1)$ for all $s$

Intuitively, you should think of a path homotopy as a continuous deformation of one path into the other, keeping the endpoints fixed at all times.  Again, for each $0<s<1$, the function $h(t, \cdot)$ is the intermediate path at “time” $s$, and none of these intermediate paths touches the obstacle point $o$.

I’ll typically use the word “homotopy” for both free homotopy and path homotopy, in the hope that the precise type is clear from context.
-->

## Vertex moves

Similar to the definition of “connected”, the definition of “homotopy” allows intermediate curves to be arbitrarily wild closed curves even if the initial and final curves are polygons.

Fortunately, there is a general principle that allows us to “tame”  homotopies between tame curves like polygons, by decomposing them into a sequence of elementary _moves_.  (This principle is similar to the observation that any closed curve can be approximated by a sequence of line segments, otherwise known as a polygon.)  

Let $P$ be any polygon.  A _vertex move_ translates exactly one point $p$ of $P$ along a straight line from its current location to a new location $p’$, yielding a new polygon $P’$.  As the point $p$ moves, the edges incident to $p$ pivot around their other endpoints.  Typically the moving point $p$ is a vertex of the initial polygon $P$ and the final point $p’$ is a vertex of the final polygon $P’$, but neither of these restrictions is required by the definition.  We are allowed to freely introduce new vertices in the middle of edges, or freely delete “flat” vertices between two collinear edges.

![A vertex move.](Fig/one-vertex-move){ width=50% }

Now suppose the polygon $P$ lives in the punctured place $\mathbb{R}^2\setminus o$.  Let $p, q, r$ be three consecutive vertices of $P$.  The vertex move $q\mapsto q’$ is _safe_ if neither of the triangles $\triangle p q q’$ or $\triangle q q’ r$. contains the obstacle point $o$.  Equivalently, during a safe vertex move, the continuously changing polygon never touches $o$.

![An unsafe vertex move and a safe vertex move.](Fig/safe-vertex-move){ width=80% }


It follows that every safe vertex move is a homotopy in $\mathbb{R}^2\setminus o$.  We can build up more complex homotopies by concatenating several safe vertex moves.  In fact, _any_ sequence of safe vertex moves describes a homotopy in $\mathbb{R}^2\setminus o$.

## Polygon homotopies are sequences of vertex moves

Unfortunately, the converse of this observation is false; not every homotopy is a sequence of vertex moves.  Consider, for example, a simple translation or rotation of the entire polygon!  Nevertheless, every homotopy can be _approximated_ by a sequence of safe vertex moves.

**Lemma:**
: If two polygons in $\mathbb{R}^2\setminus o$ are homotopic, then they are homotopic by a sequence of safe vertex moves.

**Proof:**
: Fix a homotopy $h\colon [0,1]\times S^1 \to \mathbb{R}^2\setminus o$ between two polygons $P_0 = h(0,\cdot)$ and $P_1 = h(1,\cdot)$.

: For any parameters $t$ and $\theta$, let $d(t, \theta)$ be the Euclidean distance from $h(t, \theta)$ to the origin $o$, and let $\varepsilon = \min_{t,\theta} d(t,\theta)$.  Because the cylinder $[0,1]\times S^1$ is compact, this minimum is well-defined and positive.

: We subdivide the cylinder $[0,1]\times S^1$ into triangles as follows.  First, cut the cylinder into a grid of $\delta\times\delta$ squares $\square(i,j) = [i\delta, (i+1)\delta] \times [j\delta, (j+1)\delta \bmod 1]$, where $\delta>0$ is chosen so that the diameter of $h(\square(i,j))$ is at most $\varepsilon/2$.  (The existence of $\delta$ is guaranteed by continuity.)  Then further subdivide each grid square into two right isosceles triangles, as shown in the figure below.  Without loss of generality, assume each vertex of $P_0$ and $P_1$ the image of some vertex on the boundary of the resulting triangle mesh $\Delta$.

: The homotopy $h$ maps any cycle in this mesh to a closed curve, which consists of $O(1/\delta)$ curve segments, each with diameter at most $\varepsilon/2$, and each with distance at least $\varepsilon$ from $o$.  Define a new homotopy $h’ \colon [0,1]\times S^1 \to \mathbb{R}^2\setminus o$ that agrees with $h$ at every grid vertex and linearly interpolates within each grid triangle.  Changing from $h$ to $h’$ changes the image of any grid cycle by replacing each short curve segment with a straight line segment.

: [^gmaps]: More formally, for any closed curve $\gamma \colon S^1 \to [0,1]\times S^1$ on the cylinder, the composition $h(\gamma) :- h\circ \gamma$ is a closed curve in the plane.  A cycle in the triangle mesh $\Delta$ is a closed curve on the cylinder,

: We can easily construct a sequence of $1 + 2/\delta^2$ cycles in $\Delta$ that starts with one boundary $0\times S^1$ and ends with the other boundary $1\times S^1$, such that the symmetric difference between two adjacent cycles is the boundary of one triangle in $\Delta$.  Two adjacent cycles in this sequence are shown on the right in the following fugure.

: ![A grid on the unit cylinder.](Fig/cylinder-grid){ width=60% }

: The piecewise-linear homotopy $h’$ maps any two adjacent cycles in this sequence to a pair of polygons $P_t$ and $P_{t+1}$ that differ by a single vertex move.  Every vertex of each intermediate polygon has distance at least $\varepsilon$ from the origin, each edge has length at most $\varepsilon/2$, and each vertex move translates its vertex a distance of at most $\varepsilon/2$.  It follows that every vertex move in this sequence is safe.

: We conclude that $P_0$ can be transformed into $P_1$ by a sequence of $1 + 2/\delta^2$ safe vertex moves.  


This lemma is a special case of a more general _simplicial approximation theorem_, which intuitively states that any continuous map between _nice_ topological spaces (formally, geometric simplicial complexes) can be approximated by a _nice_ continuous map (formally, simplicial maps between finite subdivisions of the original complexes); moreover, the original map can be continuously deformed to its approximation.

## Homotopy Invariant

Winding numbers are our first example of a _topological invariant_, and specifically a _complete homotopy_ invariant.  A topological invariant is any property of objects or spaces that is unchanged by some form of topological equivalence.  One simple example is the number of components of a subset of the plane; another standard example is the _genus_ of a surface.  A _homotopy_ invariant is any property that is preserved by homotopy; a homotopy invariant is _complete_ if it takes on different values for two objects that are not homotopic.

**Theorem:**
: Two polygons are homotopic in $\mathbb{R}^2\setminus o$ if and only if they have the same winding number around the origin $o$.  Thus, winding number is a complete homotopy invariant for polygons in $\mathbb{R}^2\setminus o$.

**Proof:**
: Fix two polygons $P_0$ and $P_1$ in $\mathbb{R}^2\setminus o$.  If these two polygons are homotopic, then by the previous lemma, they are connected by a sequence of safe triangle moves.  A safe triangle move does not change the winding number of a polygon around the origin.  Thus, by induction, $P_0$ and $P_1$ have the same winding number.

: To prove the converse, I'll describe a sequence of safe triangle moves that transforms any polygon $P$ into a _canonical_ polygon $\Diamond^w$ with the same winding number $w$ around the origin.  (The notation $\Diamond^w$ will make sense later, honest.)  Thus, if $P_0$ and $P_1$ have the same winding number $w$, we can deform $P_0$ into $P_1$ by concatenating the move sequence that takes $P_0$ to $\lozenge^w$ and the reverse of the move sequence that takes $P_1$ to $\lozenge^w$.

: Our homotopy consists of several stages.  First let’s consider the case where the winding number of $P$ around $0$ is not zero.

: * Let $p_i$ be any vertex of $P$, and let $p_{i-1}$ and $p_{i+1}$ be the next and previous vertices.  We call $q$ _redundant_ if the triangle $\triangle p_{i-1}p_ip_{i+1}$ does not contain the origin.  In particular, if the triples $(o,p_{i-1},p_i)$ and $(o,p_i,p_{i+1})$ have opposite orientations, one clockwise and the other counterclockwise, then $p_i$ is redundant.  In the first phase of our homotopy, we repeatedly remove redundant vertices, by moving each redundant vertex $q$ to one of its neighbors, until none are left.  The resulting polygon $P'$ is _angularly monotone_: every triple $(o,p_i,p_{i+1})$ has the same orientation.

: ![Removing three redundant vertices](Fig/winding-canonize-redundant){ width=95% }

: * Next, we subdivide $P'$ by adding vertices at its intersections with rays pointing up, down, left, and right from the origin $o$.  After this subdivision, any vertex that is _not_ on one of these rays is redundant.  So in the second phase of the homotopy, we remove all non-ray vertices using safe vertex moves.  The resulting polygon $P''$ is still angularly monotone.

: * Finally, we move each vertex so that is distance from the origin is $1$; each of these vertex moves is safe.  The resulting polygon $\Diamond^w$ has vertices only at the points $(0,1)$, $(1,0)$, $(0,-1)$, and $(-1,0)$; the polygon winds around this diamond $|w|$ times, counterclockwise if $w>0$ and clockwise if $w<0$.

: ![Making an angularly monotone polygon canonical](Fig/winding-canonize){ width=95% }

: The special case where $P$ has winding number $0$ is even simpler.  The first phase (removing redundant vertices) actually reduces $P$ to a single point; we can then translate this point to $\diamond^0 = (1,0)$ using one more safe vertex move.

This theorem immediately implies a linear-time algorithm to decide if two polygons are homotopic in the punctured plane: Count positive and negative crossings between each polygon and an arbitrary ray from the origin.



## ...and the Aptly Named Sir Not Appearing in This Film

* rotation number = total turning angle = smiles $-$ frowns
* regular homotopy = vertex moves without spurs
* rotation number is a regular homotopy invariant
* complex root finding / fundamental theorem of algebra
* signed volumes of self-intersecting polyhedra (hic utres unilaterales nascuntur)


## References

1. James W. Alexander. Topological invariants of knots and links. _Trans. Amer. Math. Soc._ 30(2):275–306, 1928.  The reason we call it “Alexander numbering”.

1. Brian Brushwood.  [Fast and Loose.](https://www.youtube.com/watch?v=1-zL3_F0lHw)  YouTube, October 19, 2015.  

1. Brian Brushwood. [Pricking the Garter.](https://www.youtube.com/watch?v=NlKuKi1l78c).  YouTube, June 26, 2017.

1. Albrecht Ludwig Friedrich Meister. Generalia de genesi figurarum planarum, et independentibus earum affectionibus. _Novi Commentarii Soc. Reg. Scient. Gott._ 1:144–180 + 9 plates, 1769/1770. Presented January 6, 1770.  The shoelace formula.

2. August F. Möbius. Über der Bestimmung des Inhaltes eines Polyëders. _Ber. Sächs. Akad. Wiss. Leipzig, Math.-Phys. Kl._ 17:31–68, 1865. _Gesammelte Werke_ 2:473–512, Liepzig, 1886.  An earlier appearance of Alexander numbering.

