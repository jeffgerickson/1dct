---
author: Jeff Erickson
numbersections: false
fontsize: 11pt
geometry:
- hmargin=1.25in
- vmargin=1in
header-includes: |
    \usepackage[charter]{mathdesign}
    \usepackage{inconsolata,sourcesanspro,stmaryrd,eucal}
    \usepackage[font={footnotesize,sf},labelfont=bf]{caption}
---


# Technical Glossary


## Topology

### The Line

- The _line_ $\mathbb{R}$ is the set of all real numbers.

- There are several types of _intervals_ on the real line:
   - _Bounded open_ interval $(a,b) := \{x \mid a < x < b\}$. 
   - _Bounded closed_ interval $(a,b) := \{x \mid a\le x \le b\}$.
   - _Bounded half-open_ intervals $(a,b] := \{x \mid a < x \le b\}$ and  $[a,b) := \{x \mid a \le x < b\}$.
   - _Open half-lines_ $(a,\infty) := \{x \mid a < x\}$ and $(-\infty,b) := \{x \mid x < b\}$.
   - _Closed half-lines_ $[a,\infty) := \{x \mid a \le x\}$ and $(-\infty,b] := \{x \mid x \le b\}$.
   - The empty set $\varnothing = (a, a)$ for any $a\in \mathbb{R}$.
   - The entire real line $\mathbb{R} = (-\infty, \infty)$.

- A subset $X\subseteq \mathbb{R}$ is _open_ if, for every point $x\in X$, there are real numbers $a$ and $b$ such that $x\in (a,b)\subseteq X$.  More concisely: A subset of $\mathbb{R}$ is open if and only if it is the union of bounded open intervals.  The empty set, bounded open intervals, open halflines, and the entire real line are open. 

- A subset $X\subseteq \mathbb{R}$ is _closed_ if and only if its complement $\mathbb{R}\setminus X$ is open.  The empty set, bounded closed intervals, closed halflines, and the entire real line are closed.  **Closed does _not_ mean “not open”!**

- A subset $X\subseteq \mathbb{R}$ is _bounded_ if it is a subset of a bounded interval.

- A subset $X\subseteq \mathbb{R}$ is _compact_ if it is both closed and bounded.

### The Plane

- The _plane_ $\mathbb{R}^2 = \mathbb{R}\times\mathbb{R}$ is the set of all ordered pairs of real numbers,

- An _open box_ is the Cartesian product of two open intervals.

- An _open disk_ is the interior of any circle.

- A subset of the plane is _open_ if it is the union of open boxes, or equivalently, the union of open disks.


### Topological Spaces

- A _topological space_ is a set $X$ together with a set $\mathcal{U}$ of subsets of $X$, called the _open subsets_ of $X$, satisfying two conditions:
   - The union of any subset of $\mathcal{U}$ is an element of $\mathcal{U}$.  That is, unions of open sets are open.
   - The intersection of any _finite_ subset of $\mathcal{U}$ is an element of $\mathcal{U}$.  That is, _finite_ intersections of open sets are open.
   
- A subset $Y$ of a topological space $X$ is _closed_ if its complement $X\setminus Y$ is open.  **Closed does not mean "not open"!**
   - The intersection of any collection of closed sets is closed.
   - The union of any _finite_ collection of closed sets is closed.

- Let $Y$ be any subset of a topological space $X$.
   - The _interior_ $Y^\circ$ of $Y$ is the union of all open subsets of $Y$.
   - The _closure_ $Y^\bullet$ of $Y$ is the intersection of all closed subsets of $Y$.
   - The _boundary_ $\partial Y$ is $Y^\bullet \setminus Y^\circ$.  (Beware: This word is overloaded!)
     
- A _cover_ of $X$ is a collection of subsets of $X$ whose union is $X$.
  - An _open cover_ of $X$ is a cover by open subsets of $X$.
  - A _finite cover_ of $X$ is a cover by a finite number of subsets of $X$.
  - If $\mathcal{C}$ is a cover of $X$, a _subcover_ of $\mathcal{C}$ is any subset of $\mathcal{C}$ that is also a cover of $X$.
  - **Caveat lector:** The word "cover" is also used as a synonym for "covering space"!

- A topological space $X$ is _compact_ if every open cover of $X$ has a finite subcover.
  - Bolzano-Weirstrauß: The two definitions of a compact subset of $\mathbb{R}$ agree.

### Building new spaces

Let $X$ and $Y$ be topological spaces.

- A **subspace** of $X$ is a subset $Z \subseteq X$ equipped with the **subset topology**: A subset $U\subseteq Z$ is open if and only if $U = V\cap Z$ for some open subset $V\subseteq X$.
  
- product space / topology 

- Let $\sim$ be any equivalence relation over $X$.  The **quotient space** $X/\sim$ is the set of equivalence classes $\{[x]_\sim \mid x\in X\}$ equipped with the **quotient topology**: A subset $Z\subseteq X/\sim$ is open if and only if $\{ x\in X \mid [x]\in U \}$ is an open subset of $X$.
   - For any subspace $Z\subseteq X$, let $\sim_Z$ be the equivalence relation where $x\sim_Z y$ if and only if $x=y$ or ($x\in Z$ and $y\in Z$).  Then $X/Z$ is another name for the quotient space $X/\sim_Z$.

- metric space / topology

### Examples

- Plane
   - Product topology
   - Metric topology

- The _circle_ $S^1$ can be defined in several equivalent ways (up to homeomorphism):
   - Subset: $S^1 = \{(x,y)\in \mathbb{R}^2 \mid x^2 + y^2 = 1\}$.
   - Quotient: $[0,1] / (0\sim 1)$ or $\mathbb{R} / \mathbb{Z}$

- Disk
   - Subset:
   - Product:

- Sphere
   - Subset:
   - Quotient:

### Functions

Fix arbitrary topological spaces $X$ and $Y$.

- A function $f\colon X\to Y$ is **continuous** if the preimage $f^{-1}(Z)$ of any open subset $Z\subseteq Y$ is an open subset of $X$.  Continuous functions are sometimes (unfortunately) called _maps_.

- A function $f\colon X\to Y$ is a **homeomorphism** if $f$ is a continuous bijection, and its inverse $f^{-1}\colon Y\to X$ is also continuous.

  - Spaces $X$ and $Y$ are _homeomorphic_ if there is a homeomorphism from $X$ to $Y$.

## Paths, Cycles, and Connectivity

Fix an arbitrary topological space $X$.

- A _path_ in $X$ is a continuous function from the interval $[0,1]$ to $X$.
- A _cycle_ in $X$ is a continuous function from the circle $S^1$ to $X$.
- A path or cycle is _simple_ if it is injective.

- A topological space $X$ is _disconnected_ if it the union of two disjoint non-empty open sets, and _connected_ otherwise.
   - Maximal connected subspaces of $X$ are called the _components_ of $X$.
- Two points $x$ and $y$ in a topological space $X$ are _path-connected_ if there is a path in $X$ from $x$ to $y$.  
   - Path-connectivity is an equivalence relation, whose equivalence classes are called the _path-components_ of $X$
   - $X$ is path connected if it has exactly one path-component.
   - Every path-connected space is connected, but not vice versa.
   - Every connected open subset of $\mathbb{R}^2$ is path-connected.


## Geometry


## Algorithms and Data Structures