---
tags:
  - programming-languages
  - part-a
---
# **Proof**
## **Problem Description**
Given $cards = Ace_1, Ace_2, Ace_3, ..., Ace_n$ and a $goal \in \mathbb{N} \ `\{0\}$, computes the best possible $score$ for the sums of aces, which can be $1$ or $11$.
### **Score**
The $score$ is calculated with the sum of all $cards$ values, the best possible $score$ for the game is $0$, and it can be calculated in the following way:
$$score = \begin{cases}
goal\ -\ sum &\text{if} \ sum \leq goal \\
3*(sum\ -\ goal) &\text{if} \ sum > goal
\end{cases}$$
## **Part 1 - Decision Tree and Properties**
To choose the value for each $Ace_i$ we can use a *Binary Decision Tree*, where each level of the tree has $2^n$ elements and has a height of $n$. 
Left Nodes represents a +11 path, right nodes is +1 path. Every level $i$ represents a $Ace_i$ decision.

In this way the tree will have, by definition, this properties:
$$\begin{cases}
parent_k & = & v \\
left_k & = & v + 11 \\
right_k & = & v + 1
\end{cases}$$
Where $0$ is the root $node$ and $left_k\ -\ right_k = 10$.

## **Part 2 - Describing Paths Through The Tree**
We can associate a variable to each decision to get all our possible sums, let $\alpha \ =\ 11\textemdash choices$ and $\beta \ =\ 1\textemdash choices$, where $\alpha \ +\ \beta \ =\ n$, so we have the following system of equations:
$$\begin{cases}
11\alpha\ +\ \beta & = & sum \\
\alpha\ +\ \beta & = & n
\end{cases}$$
Where we can confirm the property $left_k\ -\ right_k = 10$:
$$\begin{array} {rcl}
sum & = & 11\alpha \ +\ (n - \alpha) \\
sum & = & 10\alpha + n
\end{array}$$

* **Smallest Sum** -> Doesn't contain any $11-choice$, so it can be described as $0 + \beta = n = sum$.
* **Biggest Sum** -> Doesn't contain any $1-choice$, so it can be described as $11*n = sum$.

## **Part 3 - Best Score**
Let's divide all the possible scenarios into a few cases.

* $n > goal$ -> $3*(sum\ -\ goal)$
	$goal$ is smaller than the smallest possible sum, so the best $score$ will be $3*(sum\ -\ goal)$.

* $n = goal$ -> 0
	The best $score$ is $0$, as of $sum = smallest\ path = n$.

* $n < goal$
	We can divide this case into 3:
	* $goal - n \leq 3$ -> $goal - n$
		Evaluating the best case for each score, we have that the best possible score for $score_1$ is if $sum - goal = 1$, which results in $3*(sum-goal) = 3$.
		And for $score_2$ is if $goal = sum$, which results in $goal - sum = 0$.
		So if we have a sum that results in $goal - n < 3$, that **will** be our best possible sum, giving the best score of $score_2$.

	* $goal >= 11*n$ -> $goal - 11*n$
		If we take all aces to be $11$, and the goal is still not met, than our best score will be the path were all aces are worth is max value.

	* $3 + n < goal < 11 * n$ -> $\min ((goal - n) \mod 10, 3*((n - goal) \mod 10))$ 
		Let $left_j$ and $right_j$ be nodes where the following is true: $$right_j \leq goal < left_j$$
		For the property $left_k - right_k = 10$, we can manipulate the inequality above:
		$$\begin{cases}
		0 & \leq & goal\ -\ right_j & < & 10 \\
		10 & \geq & left_j - goal & > & 0
		\end{cases}$$
		Let's apply a $\mod 10$ operation to each number to make sure this result is bounded between 1 and 10:
		$$\begin{array} {lcl}
		=> goal \mod 10\ -\ right_j \mod 10 \\
		=> goal \mod 10\ -\ (10\alpha + n) \mod 10 \\
		=> (goal - n) \mod 10 
		\end{array}$$
		Which similar can be applied to $10 \geq left_j - goal > 0$, to generate the following results:
		$$score =\begin{cases}
		(goal\ -\ n) \mod 10 \\ 
		3*((n - goal) \mod 10)
		\end{cases}$$
		The best possible $score$ is $\min ((goal - n) \mod 10, 3*((n - goal) \mod 10))$.

# **Proof Extended**
Given $cards = Card_1, Card_2, ..., Card_m,Ace_1, Ace_2, Ace_3, ..., Ace_n$ and a $goal \in \mathbb{N} \ `\{0\}$, computes the best possible $score$ for the $sum$ of all $cards$, where a the value of a $card_i \in \mathbb{N}\ `\{0\}$ and $aces_{value} = 1\ or\ 11$ .

## **Part 1 - N-Root Tree is a Subtree of the Main Tree**
For a $deck$ with $m\textemdash cards$  of fixed values, first step is to sum it all non-ace cards $\displaystyle\sum_{i=1}^{m} card_i = N$, after that we can build the *binary decision tree* with $N$ as it's root.

So let's define:
* **Main Tree** -> *Binary Decision Tree* with root $0$ that represents all possible sums of aces starting from 0.
* **N-Root Tree** -> *Binary Decision Tree* with root $N$ that represents all possible sums of aces starting from the sum $N$.

$$Main =\begin{cases}
parent_k & = & v \\
left_k & = & v + 11 \\
right_k & = & v + 1
\end{cases} \quad \Rightarrow \quad
N\textemdash Root =\begin{cases}
parent_k & = & N + v \\
left_k & = & N + v + 11 \\
right_k & = & N + v + 1
\end{cases}$$

So but trees share properties and have a **Path Correspondence**, where any path from the $root$ to a leaf in the *N-Root Tree*, equals a path from node $N$ to a lead node in the *Main Tree*.
Therefore, **all** properties proved previously still holds true. $\blacksquare$ 