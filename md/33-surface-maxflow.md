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
    \setcounter{section}{24}
---

# Maximum Flows in Surface Graphs$^\varnothing$

## Real Homology

## Homologous Feasible Flows

## Shortest Paths with Negative Edges

$O(n \log^2 n / \log\log n)$ time (Real RAM)

	- ***[[[Move to planarization chapter?]]]$$$

## Ellipsoid Method (Sketch)


## Summary

To simplify notation, assume $C = n^{O(1)}$ and (because off-the-shelf algorithms are faster otherwise) $g = o(n^{1/4})$.

- $\#$ iterations $N = O(d \log \Delta)$
- Dimension $d = O(g)$
- Aspect ratio $\Delta = C^{O(g)}$
- So $N = O(g^2 \log C)$
- Oracle time $T_s = O(n\log^2 n)$
- Iteration time $O(T_s + d^2)$ arithmetic operations
- $k$th iteration requires $O(k)$ bits of precision
- So $k$th iteration takes $O(T_s A(k) + d^2 M(k))$ time
- Total time is $O(N\,A(N)\,T_s + d^2\, N\, M(N))$
- Real RAM _without_ square roots: $A(N) = O(1)$ and $M(N) = O(\log\log N)$ (for square roots)
$$
	\begin{aligned}
		O(N\,A(N)\,T_s + d^2\,N\,M(N))
		&=
		O(N\, T_s + d^2\, N \log\log N)
	\\	&=
		O(g^2 \log C)\cdot O(n\log^2 n)
		+
		O(g^2) \cdot O(g^2 \log C\log\log (g\log C))
	\\	&=
		O(g^2 n\log^2 n \log^2 C)
		+
		O(g^4 \log C \log\log (g\log C))
	\\	&=
		O(g^2 n\log^4 n)
	\end{aligned}
$$

- Bit RAM, grade school arithmetic: $A(N) = O(N)$ and $M(N) = O(N^2)$
$$
	\begin{aligned}
		O(N\,A(N)\, T_s + d^2\,N\,M(N))
		&=
		O(N^2 T_s + N^3 d^2)
	\\	&=
		O(g^4 \log^2 C)\cdot O(n\log^2 n)
		+
		O(g^6 \log^3 C)\cdot O(g^2)
	\\	&=
		O(g^4 n\log^2 n \log^2 C)
		+
		O(g^8 \log^3 C)
	\\	&=
		O(g^4 n\log^4 n)
		+
		O(g^8 \log^3 n)
	\end{aligned}
$$
First term dominates because $g = O((n\log n)^{1/4})$. 

- Fast bit RAM: $A(N) = O(N)$ and $M(N) = O(N\log N)$
$$
	\begin{aligned}
		O(N\,A(N)\, T_s + d^2\,N\,M(N))
		&=
		O(N^2 T_s +  d^2 N^2\log N)
	\\	&=
		O(g^4 \log^2 C)\cdot O(n\log^2 n)
		\\
		&\qquad {}+
		O(g^2)\cdot O(g^4 \log^2 C \log (g\log C))
	\\	&=
		O(g^4 n\log^2 n \log^2 C)
		+
		O(g^6 \log^2 C \log (g\log C))
	\\	&=
		O(g^4 n\log^4 n)
	\end{aligned}
$$
First term dominates because $g = o(\sqrt{n\log n})$.

- Fast word RAM: $A(N) = M(N) = O(N)$ --- Need to verify square root time
$$
	\begin{aligned}
		O(N\,A(N)\, T_s + d^2\,N\,M(N))
		&=
		O(N^2 T_s + d^2 N^2)
	\\	&=
		O(g^4 \log^2 C)\cdot O(n\log^2 n)
		+
		O(g^2)\cdot O(g^4 \log^2 C)
	\\	&=
		O(g^4 n\log^2 n \log^2 C) + O(g^6 \log^2 C)
	\\	&=
		O(g^4 n\log^4 n)
	\end{aligned}
$$
$\dots$ because $g = o(\sqrt{n})$


**Theorem:**
_Let $\Sigma$ be a surface map with $n$ vertices, genus $g = o(\sqrt{n\log n})$, positive integer edge capacities less than $n^{O(1)}$, and two vertices $s$ and $t$.  We can compute the maximum $(s,t)$-flow in $\Sigma$ in 
$O(g^4 n\log^4 n)$ time._


## References

1. Alt JACM 1988

1. Brent JACM 1976

1. Chambers Erickson Nayyeri

1. fast integer multiplication

1. Fürer arXiv:1402.1811

## Aptly Named Sir

- Directed graphs
- Non-orientable surfaces(?)
- Multi-dimensional parametric search
- Min-cost homologous circulations
- Spectral min-cost-flow algorithms, scaling