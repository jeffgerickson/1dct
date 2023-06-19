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

# Maximum Flow$^{\varnothing/\alpha}$


![Harris and Ross’s map of the Warsaw-Pact railway network.](Fig/HarrisRoss55-railflowcut){ width=90% }

## Background

Here I’ll provide a brief overview of standard definitions related to the maximum flow problem.  For a more thorough and gentler introduction, see chapters 10 and 11 in my algorithms textbook.

### Pseudoflows, flows, and circulations {-}

Recall that a _pseudoflow_ (or _1-chain_, or _discrete 1-form_) in a graph $G$ is any function $\phi \colon D(G) \to \mathbb{R}$ on the darts of $G$ that is antisymmetric, meaning $\phi(d) = - \phi(\textsf{rev}(d))$ for every dart $d$.  Intuitively, the value $\phi(u{\to}v)$ represents the rate of flow of some divisible substance like water, train cars, or network packets from $u$ to $v$ along the undirected edge $uv$.  In particular, a negative value indicates that the substance is flowing backward from $v$ to $u$.[^pos]

[^pos]: A more common textbook definition of (pseudo)flow is any function $\phi \colon D(G) \to \mathbb{R}$ such that for every dart $d$, we have $\phi(d)\ge 0$ and either $\phi(d) = 0$ or $\phi(\textsf{rev}(d)) = 0$.  That is, for each edge, instead of choosing an arbitrary values for the darts that sum to $0$, we choose both a direction and a non-negative value for the edge.  Converting between the antisymmetric formulation and the non-negative formulation is straightforward.

The _boundary_ $\partial\phi\colon V(G)\to \mathbb{R}$ of a pseudoflow $\phi$ that intuitively describes the total net flow into each vertex $v$:
$$
	\partial\phi(v) := \sum_u \phi(u{\to}v).
$$
A _circulation_ is a pseudoflow $\phi$ whose boundary $\partial\phi$ is identically zero.  Intuitively, circulations are pseudoflows that respect conservation of mass; any positive flow into $v$ must be balanced by negative flow into $v$ (that is, positive flow out of $v$).

For two fixed vertices $s$ and $t$, an _$(s,t)$-flow_ is a pseudoflow $f$ such that $\partial f(v) = 0$ for all $v$ except possibly $s$ and $t$.  The _value_ of an $(s,t)$-flow $\phi$ is the total net flow into $t$ or out of $s$:
$$
	|\phi| := \partial \phi(t) = -\partial \phi(s).
$$
Intuitively, $(s,t)$-flows model some substance being injected into a network of pipes at $s$ and being extracted at $t$, with conservation at every other vertex.  Every circulation is an $(s,t)$-flow with value $0$.

**Lemma:** _For any two $(s,t)$-flows $\phi$ and $\psi$ in the same graph $G$ and any two real numbers $\alpha$ and $\beta$, the function $\alpha\phi + \beta\psi$ is an $(s,t)$-flow in $G$ with value $\alpha|\phi| + \beta|\psi|$.  In particular, if $\phi$ and $\psi$ are circulations, then $\alpha\phi + \beta\psi$ is also a circulation.  Thus, circulations and $(s,t)$-flows in any graph $G$ define vector spaces._

We can regard any directed cycle $\gamma$ as a circulation:
$$
	\gamma(d) = \begin{cases}
		1 & \text{if $d \in \gamma$} \\
		-1 & \text{if $\textsf{rev}(d) \in \gamma$} \\
		0 & \text{otherwise}
	\end{cases}
$$
Similarly, we can regard any directed path $\pi$ from $s$ to $t$ as an $(s,t)$-flow:
$$
	\pi(d) = \begin{cases}
		1 & \text{if $d \in \pi$} \\
		-1 & \text{if $\textsf{rev}(d) \in \pi$} \\
		0 & \text{otherwise}
	\end{cases}
$$

**Lemma:** _Every circulation is a weighted sum of simple directed cycles.  Every $(s,t)$-flow is a weighted sum of simple directed $(s,t)$-paths and simple directed cycles._

### Capacities and residual graphs {-}

A _capacity_ function for a graph $G$ is any function $c\colon D(G)\to\mathbb{R}$ from the darts to the reals.  Capacities are not necessary either symmetric, antisymmetric, or non-negative.  A _flow network_ is a graph $G$ together with a capacity function $c$.

A pseudoflow (or circulation or $(s,t)$-flow) $\phi$ is _feasible_ with respect to $c$ if and only if $\phi(d) \le c(d)$ for every dart $d$.  In particular, we allow the capacity of a dart to be negative; a negative dart capacity is equivalent to a positive _lower bound_ on the amount of flow through the reversal of the dart.  The zero flow $\phi\equiv 0$ is feasible if and only if every dart has non-negative capacity.

Given a graph $G$, capacity function $c$, and two vertices $s$ and $t$ as input, the maximum flow problem asks for a feasible $(s,t)$-flow in $G$ with the largest possible value.

Fix a graph $G$ and a capacity function $c$.  Any pseudoflow $\phi$ in $G$ induces a _residual capacity_ function $c_\phi\colon D(G)\to \mathbb{R}$, defined simply as $c_\phi(d) = c(d) - \phi(d)$.  A pseudoflow $\phi$ is feasible if and only if every dart has non-negative residual capacity.  The _residual graph_ $G_\phi$ is just the original graph $G$ but with the new capacity function $c_\phi$.  A _residual path_ (respectively, _residual cycle_) is a directed path (respectively, directed cycle) in $G_\phi$ in which every dart has _positive_ residual capacity.

The standard textbook algorithm for maximum flows, proposed by Lester Ford and Delbert Fulkerson in 1953, is the _augmenting path_ method.  The method starts by finding an initial feasible $(s,t)$-flow $\phi$; typically all capacities are non-negative, so we can start with the zero flow $\phi\equiv 0$.  Then we repeatedly _augment_ the flow $\phi$ by _pushing_ more flow along paths from $s$ to $t$.  Specifically, at each iteration, we find a residual path $\pi$ and augment the flow by setting $\phi’ \gets \phi + \min_{d\in\pi} c_\phi(d) \cdot \pi$; here I’m treating $\pi$ both as a sequence of darts and as an $(s,t)$-flow.  Straightforward definition-chasing implies that if the original flow $\phi$ is feasible, then the augmented flow $\phi’$ is also feasible.  When $G_\phi$ contains no more residual paths, $\phi$ is a maximum $(s,t)$-flow.  More generally:

**Lemma:** _Let $\phi$ and $\phi’$ be any (not necessarily feasible) $(s,t)$-flows in $G$._

(a) _$\phi’$ is a feasible $(s,t)$-flow in $G$ if and only if $\phi’-\phi$ is a feasible $(s,t)$-flow in the residual graph $G_\phi$._
(b) _In particular, if $|\phi| = |\phi’|$, then $\phi’$ is a feasible $(s,t)$-flow in $G$ if and only if $\phi’-\phi$ is a feasible **circulation** in $G_\phi$._
(c) _In particular, $\phi’$ is a **maximum** $(s,t)$-flow in $G$ if and only if $\phi’-\phi$ is a **maximum** $(s,t)$-flow in $G_\phi$._

## Planar Circulations

Flows and circulations have particularly nice structure in planar graphs, or more accurately, in planar _maps_.

Fix an arbitrary circulation $\phi$ in an arbitrary planar map $\Sigma$, with a distinguished outer face $o$.
The _winding number_ of $\phi$ around each face $f$ of $\Sigma$, denoted $\textsf{wind}(\phi, f)$ can be defined by extending the definition of the Alexander numbering of a curve:

- $\textsf{wind}(\phi, o) = 0$
- For every dart $d$, we have $\textsf{wind}(\phi, \textsf{left}(d)) = \phi(d) + \textsf{wind}(\phi, \textsf{right}(d))$.

Conservation at each vertex $v$ implies that this st of constraints has a unique solution.  Equivalently, for any path (in fact, any _walk_) $\pi$ in the dual map $\Sigma^*$ from dual of the outer face $o^*$ to the dual vertex $f^*$, we have
$$
	\textsf{wind}(\phi, f) = \sum_{d^*\in\pi} \phi(d).
$$
The second definition is independent of the choice of dual path $\pi$, again by conservation.  A third equivalent definition uses the fact that $\phi$ is a weighted sum of simple cycles:
$$
	\phi = \sum_i \alpha_i\cdot \gamma_i
	\implies
	\textsf{wind}(\phi, f) = \sum_i \alpha_i\cdot \textsf{wind}(\gamma_i, f);
$$
This definition is independent of the chosen decomposition of $\phi$ into cycles $\gamma_1, \gamma_2, \dots$.

<!--
**Lemma:**
_Fix a planar map $\Sigma$.  For any circulation $\phi$ in $\Sigma$, and any circulation $\theta$  in the dual map $\Sigma^*$, we have $\sum_d \phi(d) \cdot \theta(d^*) = 0$, where the sum is over the darts of $\Sigma$._

**Proof:**
: Because every circulation can be expressed as a sum of simple directed cycles, it suffices to consider a simple directed cycle $\gamma$ in $\Sigma$ and a simple directed cycle $\lambda$ in $\Sigma^*$.

: The Jordan curve theorem implies that these two cycles intersect an even number of times; specifically, the number of times that $\gamma$ crosses $\lambda$ from left to right is equal to the number of times $\gamma$ crosses $\lambda$ from right to left.  Every crossing is the intersection of an edge of $\Sigma$ with its dual edge in $\Sigma^*$.

: Consider an arbitrary dart $d$ in $\gamma$.  The dual dart $d^*$ is in $\theta$ if and only if $\gamma$ crosses $\theta$ from left to right at the point $d\cap d^*$.  Conversely, $\textsf{rev}(d^*) = \textsf{rev}(d)^* \in \theta$ if and only if $\gamma$ crosses $\theta$ from right to left at the point $d\cap d^*$.  Thus, each left-to-right crossing contributes $2$ to the sum $\sum_d \gamma(d) \cdot \lambda(d^*) = 0$ (one from the dart $d\in\gamma\cap\theta^*$ and one from its reversal), and each right-to-left crossing contributes $-2$. $\qquad\square$
-->

Alexander numbering is an example of a _face potential_ (or $2$-chain); more generally, a face potential in $\Sigma$ is any function $\alpha\colon F(\Sigma)\to\mathbb{R}$ assigning a real number to each face of $\Sigma$.  The _boundary_ of a face potential $\alpha$ is the circulation $\partial\alpha\colon D(\Sigma)\to \mathbb{R}$ defined by setting
$$
	\partial\alpha(d) = \alpha(\textsf{left}(d)) - \alpha(\textsf{right}(d))
$$
for every dart $d$.  It should be easy to verify that $\partial\alpha$ is indeed a circulation.  Moreover, the boundary operator $\partial$ is linear; for all face potentials $\alpha$ and $\beta$ and real numbers $a$ and $b$, we have $\partial(a\cdot\alpha + b\cdot\beta) = a\cdot\partial\alpha + b\cdot\partial\beta$.

The following lemma is a natural generalization (and consequence) of the Jordan Curve Theorem.

**Lemma:**
_Every circulation in a planar map is a boundary circulation._

**Proof:**
: For any circulation $\phi$, routine definition-chasing implies $\phi = \partial (\textsf{wind}(\phi))$.  That is, $\phi = \partial\alpha$, where $\alpha(f) = \textsf{wind}(\alpha, f)$ for every face $f$.  $\qquad\square$

**Corollary:**
_The difference between any two $(s,t)$-flows with the same value in the same planar map $\Sigma$ is a boundary circulation in $\Sigma$._

## Feasible Planar Circulations and Shortest Paths

Now suppose we endow our planar map $\Sigma$ with a capacity function $c\colon D(\Sigma)\to\mathbb{R}$.  Every dart $d^*$ in the dual map $\Sigma^*$ has a _cost_ or _length_ $c(d^*)$ equal to the capacity of the corresponding primal dart $d$; in short, we have $c(d^*) = c(d)$.

**Lemma [Venkatesan]:**
_Let $\Sigma$ be any planar map, and let $c\colon D(\Sigma)\to\mathbb{R}$ be any capacity function for $\Sigma$.  There is a feasible circulation in $\Sigma$ if and only if the dual map $\Sigma^*$ has no negative cycles._

**Proof:**
: First, consider an arbitrary circulation $\phi$ in $\Sigma$ and an arbitrary cycle $\lambda^*$ in the dual map $\Sigma^*$ with negative total cost.  Without loss of generality, assume $\lambda^*$ is simple and oriented counterclockwise.  Whitney’s duality theorem implies that the set $\lambda$ of primal darts whose duals lie in $\lambda^*$ define a _directed edge cut_.  Specifically, let $A$ denote the vertices of $\Sigma$ whose corresponding dual faces lie inside $\lambda^*$.  Then $\lambda$ is the set of all darts in $\Sigma$ such that $\textsf{head}(d)\in A$ and $\textsf{tail}(d) \not\in A$.  Straightforward calculation implies
$$
	\begin{aligned}
		\sum_{d\in \lambda} \phi(d)
		&=
		\sum_{\textsf{head}(d)\in A} \phi(d)
			& \text{because $\phi(d) = -\phi(\textsf{rev}(d))$}
		\\ &=
		\sum_{v\in A\vphantom{[}} ~ \sum_{\textsf{head}(d) = v} \phi(d)
		\\ &=
		\sum_{v\in A} \partial\phi(v)
			& \text{by definition of $\partial$}
		\\ &=
		\sum_{v\in A} 0
			& \text{because $\phi$ is a circulation}
		\\ &= 0
		\\ & > \sum_{d\in \lambda} c(d).
	\end{aligned}
$$
(In the first step, we are adding $\phi(d)$ for all darts with both endpoints in $A$.)  We conclude that $\phi(d) > c(d)$ for at least one dart $d\in\lambda$; in short, $\phi$ is not feasible.

: On the other hand, suppose shortest-path distances are well-defined in $\Sigma^*$.  For any dual vertex $p$, let $\textsf{dist}(p)$ denote the shortest-path distance from the outer face $o$ to $p$.  We can interpret the function $\textsf{dist}$ as a face potential function for $\Sigma$.  I claim that the boundary circulation $\partial\textsf{dist}$ is feasible.  For any dart $d$, we have 
$$
	\phi(d)
	~=~
	\textsf{dist}(\textsf{left}(d)^*) - \textsf{dist}(\textsf{right}(d)^*)
$$
Now define the _slack_ of every dart $d$ as
$$
	\begin{aligned}
		\textsf{slack}(d)
		& := c(d) - \phi(d)
		\\
		& = 
		c(d) - \textsf{dist}(\textsf{left}(d)^*) + \textsf{dist}(\textsf{right}(d)^*)
		\\
		& =
		\textsf{dist}(\textsf{tail}(d^*)) + c(d^*) - \textsf{dist}(\textsf{head}(d^*))
	\end{aligned}
$$
The definition of shortest paths implies that $\textsf{slack}(d) \ge 0$ for every dart $d$, and thus $\phi(d) \le c(d)$ for every dart $d$.  We conclude that $\phi$ is feasible.

**Corollary:**
_Given a planar map $\Sigma$ with $n$ vertices and arbitrary dart capacities, we can compute either a feasible circulation in $\Sigma$ or a negative-cost cycle in $\Sigma^*$ in $O(n\log^2 n)$ time._

**Proof:**
: Run the shortest-path algorithm of Klein, Mozes, and Weimann, starting at the vertex $o^*$ dual to the outer face $o$.  If shortest-path distances in $\Sigma^*$ are well-defined, set $\phi(d) = 	\textsf{dist}(\textsf{left}(d)^*) - \textsf{dist}(\textsf{right}(d)^*)$ for every dart $d$.  Otherwise, the algorithm finds a negative cycle in $\Sigma^*$.  In both cases, the algorithm runs in $O(n\log^2 n)$ time.

## Our First Planar Max-flow Algorithm

The previous lemma can also be used to find feasible $(s,t)$-flows with particular values.  Fix two vertices $s$ and $t$ in $G$.

**Corollary:**
_Let $\phi$ be an arbitrary (not necessarily feasible) $(s,t)$-flow in $\Sigma$.  There is a feasible $(s,t)$-flow in $G$ with value $|\phi|$ if and only if the dual residual map $\Sigma^*_\phi$ has no negative cycles._

**Corollary:**
_Given a planar map $\Sigma$ with $n$ vertices, arbitrary dart capacities, and a real number $\lambda$, we can either compute a feasible $(s,t)$-flow in $\Sigma$ with value $\lambda$, or correctly report that no such flow exists, in $O(n\log^2 n)$ time._

**Proof:**
: Let $\pi$ be any path from $s$ to $t$ in $\Sigma$ with value $\lambda$, and let $\phi$ be the flow $\lambda\cdot\pi$.  Then $\phi’$ is a _feasible_ $(s,t)$-flow with value $\lambda$ if and only if $\phi’-\phi$ is a feasible circulation in the residual map $\Sigma_\phi$.  $\qquad\square$

**Corollary:**
_Given a planar map $\Sigma$ with $n$ vertices, non-negative **integer** dart capacities $c(d)$, we can compute a maximum $(s,t)$-flow in $\Sigma$ in $O(n\log^2 n \log (nU))$ time, where $U = \max_d c(d)$._

**Proof:**
: Suppose every dart in $\Sigma$ has an integer capacity between $0$ and $U$.  Because all capacities are non-negative, we know that the zero circulation is a feasible flow with value $0$, and the upper bound on individual capacities implies that every feasible flow has value at most $nU$.  If there is a feasible flow with any value $\lambda$, we can scale it down to a feasible flow with any value smaller than $\lambda$.  Finally, Ford and Fulkerson’s augmenting-path algorithm implies by induction that the maximum flow in a network with integer capacities has integer value.  Thus, we can compute a maximum flow in $\Sigma$ by performing a binary search over the $nU$ possible flow values, running the $O(n\log^2 n)$-time decision algorithm at each iteration.  $\qquad\square$

I find this algorithm deeply unsatisfying, in part because it requires integer capacities, but it does at least serve as a proof of concept.  Hassin and Johnson proved that for _undirected_ planar graphs, where every dart has the same capacity as its reversal, we can compute a maximum $(s,t)$-flow by first running Reif’s minimum-cut algorithm and then running Dijkstra’s algorithm in a modified dual graph.  Using Reif’s original algorithm, this approach funds maximum flows in $(n\log^2 n)$ time; this running time can be improved to $O(n\log n)$ using either the linear-time shortest-path algorithm of Henzinger et al inside Reif’s algorithm, or by replacing Reif’s algorithm with multiple-source shortest paths.

Unfortunately, this approach does not extend to directed planar graphs, because we do not have a similar divide-and-conquer minimum-cut algorithm in that setting.  In 1997, Karsten Weihe described an algorithm to compute maximum flows in directed planar graphs in $O(n\log n)$ time, generalizing his earlier $O(n)$-time algorithm for undirected unit-capacity planar graphs.  However, his algorithm assumes that every dart in the input graph appears in at leas one simple path from $s$ to $t$.  Darts that do not satisfy this criterion can be safely removed from the input graph, but an efficient algorithm to find all such “useless” darts was only found in 2017, by Jittat Fakcharoenphol, Bundit Laekhanukit, and Pattara Sukprasert.

Meanwhile, in 2006, Glencora Borradaile and Philip Klein discovered a much cleaner algorithm to compute planar maximum flows in $O(n\log n)$ time.  In the rest of this lecture note I will describe a reformulation of their algorithm that I published in 2010.

## Parametric Shortest Paths

We formulate the planar maximum-flow problem as a _parametric shortest-path_ problem, similar to our first  multiple-source shortest-path problem.  Fix an arbitrary path $\pi$ from $s$ to $t$.  We are trying to find the largest value $\lambda$ such that $\Sigma$ supports and $(s,t)$-flow with value $\lambda$.  Equivalently, by the arguments in the last two sections, we are looking for the largest value $\lambda$ such that the dual residual map $\Sigma^*_{\lambda\cdot\pi}$ does not contain a negative cycle.  The algorithm maintains a shortest-path tree in the dual residual map $\Sigma^*_{\lambda\cdot\pi}$ as the parameter $\lambda$ continuously increases from $0$.  At critical values of $\lambda$, darts $p{\to}q$ in $\Sigma^*$ become tense and pivot into the shortest-path tree, replacing earlier darts $p’{\to}q$.  The algorithm halts when a pivot introduces a cycle into the shortest-path tree, which would become negative if we increased $\lambda$ any further.  (That cycle is dual to the minimum cut!)

Again, we fix an arbitrary path $\pi$ from $s$ to $t$; we treat this path as a flow with value $1$:
$$
	\pi(d) = \begin{cases}
		1 & \text{if $d \in \pi$} \\
		-1 & \text{if $\textsf{rev}(d) \in \pi$} \\
		0 & \text{otherwise}
	\end{cases}
$$
We also fix a vertex $o$ in the dual map $\Sigma^*$.  Let’s establish some notation.

- $\Sigma_\lambda$ is just shorthand for the residual graph $\Sigma_{\lambda\cdot\pi}$.
- $c(\lambda, d) = c(\lambda, d^*) = c(d) - \lambda\cdot\pi(d)$ is the capacity of $d$ in the residual graph $\Sigma$, and therefore the cost of $d^*$ in the dual residual map $\Sigma_\lambda^*$.
- $T_\lambda$ is the single-source shortest-path rooted at $o$ in $\Sigma_\lambda^*$.
- $\textsf{dist}(\lambda, p)$ is the shortest-path distance from $o$ to $p$ in $\Sigma_\lambda^*$.
- $\textsf{path}(\lambda, p)$ is the shortest path from $o$ to $p$ in $\Sigma_\lambda^*$.
- $\textsf{pred}(\lambda, p)$ is the second-to-last vertex of $\textsf{path}(\lambda, p)$.
- $\textsf{slack}(\lambda, p{\to}q) = \textsf{dist}(\lambda, p) + c(\lambda, p{\to}q) - \textsf{dist}(\lambda, p)$
- $\textsf{cycle}(\lambda, p{\to}q)$ is the closed walk obtained by concatenating $\textsf{path}(\lambda, p)$, $p{\to}q$, and $\textsf{rev}(\textsf{path}(\lambda,q))$.
- A dart $d$ of $\Sigma_\lambda$ is _tense_ if $\textsf{slack}(\lambda, d^*) = 0$.
- An edge $e$ of $\Sigma_\lambda$ is _loose_ if neither of its darts is tense.
- $L_\lambda$ is the subgraph of all loose edges in $\Sigma_\lambda$.
- A dart $d$ in $\Sigma_\lambda$ is _active_ if $\textsf{slack}(\lambda, d^*)$ is decreasing at $\lambda$.
- $LP_\lambda$ is the set of all active darts in $\Sigma_\lambda$.

Except at critical values of $\lambda$, subgraph $L_\lambda$ is a spanning tree of $\Sigma_\lambda$, and in fact $(L_\lambda, T_\lambda)$ is a tree-cotree decomposition of $\Sigma$.

**Lemma:** _$LP_\lambda$ is the unique path from $s$ to $t$ in $L_\lambda$._

**Lemma:** _$LP_\lambda$ is the set of all active darts in $\Sigma_\lambda$._


## Active Darts

## Fast Pivots

## Universal Cover Analysis


## References

\frenchspacing

1. Therese C. Biedl, Bronǎ Brejová, and Tomáš Vinař. [Simplifying flow networks](https://doi.org/10.1007/3-540-44612-5_15). _Proc. 25th Symp. Math. Found. Comput. Sci._, 192–201, 2000. Lecture Notes Comput. Sci. 1893, Springer-Verlag.

1. Glencora Borradaile and Anna Harutyunyan.  [Maximum st-flow in directed planar graphs via shortest paths](https://doi.org/10.1007/978-3-642-45278-9_36). _Proc. 24th Int. Workshop Combin. Algorithms_, 423–427, 2013. Lecture Notes Comput. Sci. 8288, Springer. arXiv:[1305.5823](https://arxiv.org/abs/1305.5823).

3. Glencora Borradaile and Philip Klein. [An $O(n\log n)$ algorithm for maximum st-flow in a directed planar graph](https://doi.org/10.1145/1502793.1502798). _J. ACM_ 56(2):1–9:1–30, 2009.

1. David Eppstein and Kevin A. Wortman. [Optimal embedding into star metrics](https://doi.org/10.1007/978-3-642-03367-4_26).  _Proc. 11th Algorithms Data Struct. Symp. (WADS)_, 290–301, 2009. Lecture Notes Comput. Sci. 5664, Springer.  Another application of parametric shortest paths.

1. Jeff Erickson. [Parametric shortest paths and maximum flows in planar graphs](https://doi.org/10.1137/1.9781611973075.65). _Proc. 21st Ann. ACM-SIAM Symp. Discrete Algorithms_, 794–804, 2010.

1. Jittat Fakcharoenphol, Bundit Laekhanukit, and Pattara Sukprasert. [Finding all useless arcs in directed planar graphs](https://arxiv.org/abs/1702.04786). Preprint, May 2018. arXiv:[1702.04786](
https://doi.org/10.48550/arXiv.1702.04786).

1. Lester R. Ford and Delbert R. Fulkerson.  [Maximal flow through a network](http://doi.org/10.4153/CJM-1956-045-5). _Canad. J. Math._ 8(399–404), 1956.  First published as [Research Memorandum RM-1400](https://www.rand.org/pubs/papers/P605.html), The RAND Corporation, Santa Monica, California, November 19, 1954.

1. Lester R. Ford and Delbert R. Fulkerson.  [_Flows in Networks_](https://www.jstor.org/stable/j.ctt183q0b4). Princeton University Press, 1962.  First published as [Research Memorandum R-375-PR](https://www.rand.org/pubs/reports/R375.html), The RAND Corporation, Santa Monica, California, August 1962.

1. Theodore E. Harris and Frank S. Ross. [Fundamentals of a method for evaluating rail net capacities](https://apps.dtic.mil/sti/citations/AD0093458).  Research Memorandum RM-1573, The RAND Corporation, Santa Monica, California, October 24, 1955.  Declassified May 13, 1999.

1. Refael Hassin and Donald B. Johnson. [An $O(n \log^2 n)$ algorithm for maximum flow in undirected planar networks](https://doi.org/10.1137/0214045).  _SIAM J. Comput._ 14(3):612–624, 1985.

5. Samir Khuller, Joseph (Seffi) Naor, and Philip Klein.  [The lattice structure of flow in planar graphs](https://doi.org/10.1137/0406038). _SIAM J. Discrete Math._ 477–490, 1993.  Removing clockwise residual cycles.

1. Karl Menger. [Zur allgemeinen Kurventheorie](http://doi.org/10.4064/fm-10-1-96-115). _Fund. Math._ 10:96–115, 1927.

1. Shankar M. Venkatesan.  [_Algorithms for network flows_](https://www.proquest.com/docview/303173800). Ph.D. thesis, The Pennsylvania State University, 1983.

1. Karsten Weihe. [Edge-disjoint $(s,t)$-paths in undirected planar graphs in linear time](http://doi.org/10.1006/jagm.1996.0831). _J. Algorithms_ 23(1):121–138, 1997.

1. Karsten Weihe. [Maximum $(s,t)$-flows in planar networks in $O(|V|\log|V|)$ time](https://doi.org/10.1006/jcss.1997.1538). _J. Comput. Syst. Sci._ 55(3):454–476, 1997.



## Aptly Not

