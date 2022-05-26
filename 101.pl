% Group 101

% Sean Coaker 986529
% Abdelrahman Bahaaeldin Hassan Abdelhalim 988156
% Noah Isaac Roberts 975804


% Program: ROYAL
parent(queenmother,elisabeth). 
parent(elisabeth,charles).
parent(elisabeth,andrew). 
parent(elisabeth,anne).
parent(elisabeth,edward). 
parent(diana,william).
parent(diana,harry). 
parent(sarah,beatrice).
parent(anne,peter). 
parent(anne,zara).
parent(george,elisabeth). 
parent(philip,charles).
parent(philip,andrew). 
parent(philip,edward).
parent(charles,william). 
parent(charles,harry).
parent(andrew,beatrice). 
parent(andrew,eugenie).
parent(mark,peter). 
parent(mark,zara).
parent(william,georgejun). 
parent(kate,georgejun).
parent(william,charlotte). 
parent(kate,charlotte).
parent(philip,anne). 
parent(william,louis).
parent(kate,louis). 
parent(harry,archie).
parent(meghan,archie).

the_royal_females([queenmother,elisabeth,anne,diana,sarah,beatrice,zara,eugenie,charlotte,kate,meghan]).

the_royal_males([charles,andrew,edward,william,harry,peter,george,philip,mark,georgejun,louis,archie]).

% Question 1

% 1)

% append function for appending elements to a list
append([],L,L).
append([H|T],L1,[H|L2]) :- append(T,L1,L2).

% function to combine royal males and royal females to produce royal family
the_royal_family(Z) :- 
	the_royal_males(X),
	the_royal_females(Y),
	append(X,Y,Z).

% 2)

% function to check if element is member of a list
member(X,[X|_]).
member(X,[_|T])  :-  member(X,T).

% function for finding all fathers in the royal family
father(X,Y) :- 
	the_royal_males(Z),
	parent(X,Y),
	member(X,Z).

% 3)

% function for finding all granddads in the royal family
granddad(X,Z) :-
	the_royal_males(Q),
	parent(X,Y),
	parent(Y,Z),
	member(X,Q).

% 4)

% function for finding all members of royal family that have a child
has_child(X) :- parent(X,_).

% 5)

% function for finding all ancestors in the royal family
ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(X,Z), ancestor(Z,Y).

% 6)

% function for finding all siblings in the royal family
sibling(X,Y) :- parent(Z,X), parent(Z,Y), X \= Y.

% 7)

% function for finding all brothers in the royal family
brother(X,Y) :- 
	the_royal_males(Q),
	parent(Z,X),
	parent(Z,Y),
	member(X,Q),
	X \= Y.

% 8)

/* 
?- granddad(george,Y).
Y = charles ;
Y = andrew ;
Y = anne ;
Y = edward ; 
*/

% 9)

/*
?- parent(X,_).
X = queenmother ;
X = elisabeth ;
X = elisabeth ;
X = elisabeth ;
X = elisabeth ;
X = diana ;
X = diana ;
X = sarah ;
X = anne ;
X = anne ;
X = george ;
X = philip ;
X = philip ;
X = philip ;
X = charles ;
X = charles ;
X = andrew ;
X = andrew ;
X = mark ;
X = mark ;
X = william ;
X = kate ;
X = william ;
X = kate ;
X = philip ;
X = william ;
X = kate ;
X = harry ;
X = meghan.
*/

% 10)

/*
?- ancestor(diana,Y).
Y = william ;
Y = harry ;
Y = georgejun ;
Y = charlotte ;
Y = louis ;
Y = archie ;
false.
*/

% 11)

/*
?- ancestor(X,archie).
X = harry ;
X = meghan ;
X = queenmother ;
X = elisabeth ;
X = diana ;
X = george ;
X = philip ;
X = charles ;
false.
*/

% 12)

% function for finding all members of royal family that have a brother that is also a granddad
has_brother_who_is_granddad(X,Y) :- brother(Y,X),granddad(Y,_).

/*
?- has_brother_who_is_granddad(X,_).
X = andrew ;
X = andrew ;
X = andrew ;
X = andrew ;
X = anne ;
X = anne ;
X = anne ;
X = anne ;
X = edward ;
X = edward ;
X = edward ;
X = edward ;
X = andrew ;
X = andrew ;
X = andrew ;
X = andrew ;
X = edward ;
X = edward ;
X = edward ;
X = edward ;
X = anne ;
X = anne ;
X = anne ;
X = anne ;
false.
*/


% Question 2

% a)

% function that checks if input is odd, if so it returns the value*2 otherwise it returns the value
odd_to_even(X,Y) :- (X mod 2 =\= 0 -> Y is X*2 ; Y = X).

% function that changes all odd elements in a list to even with the odd_to_even function
toEven([],[]).
toEven([H1|L1],[H2|L2]) :- odd_to_even(H1,H2),toEven(L1,L2).

% b)

star(0).
star(1) :- print('*').
star(N) :- 
	N > 1,
	foreach(between(1,N,_),print('*')),
	nl,
	N1 is N-1,
	star(N1).
	
star2(N) :-
	N > 0,
	star(N),
	starup(N).
	
starup(N) :- 
	between(2,N,X), nl,
	between(1,X,_), print('*'), fail.
	
/*
?- star(3).
***
**
*
true .
*/

/*
?- star2(3).
***
**
*
**
***
false.
*/


% Question 3

% a)

% function to return euclidean distance with use of euclidsqrcalc and accumulator
euclidsqr(X,Y,ED) :- 
	length(X,L),
	length(Y,L2),
	L =:= L2,
	euclidsqrcalc(X,Y,L,0,ED2),
	ED is ED2.
	
% recursive function that produces euclidean distance. Uses length of list and counts down to 0 instead of using head/tail recursion.
euclidsqrcalc([],[],_,A,A).
euclidsqrcalc(X,Y,L,A,ED2) :- 
	L > 0,
	nth1(L,X,E1,X2),
	nth1(L,Y,E2,Y2),
	NewA is A+((E1-E2)*(E1-E2)),
	NewL is L-1,
	euclidsqrcalc(X2,Y2,NewL,NewA,ED2).
	
% b)

% function to return euclidean distance with use of euclidsqr2calc and accumulator
euclidsqr2(X,Y,ED) :- 
	euclidsqr2calc(X,Y,0,ED2),
	ED is ED2.

% recursive function that produces euclidean distance. Uses head/tail recursion
euclidsqr2calc([],[],A,A).
euclidsqr2calc([H1|X],[H2|Y],A,ED2) :- 
	NewA is A+((H1-H2)*(H1-H2)),
	euclidsqr2calc(X,Y,NewA,ED2).

% Question 4

% 1)

% function for returning list after removing the element that was input from the list
member_rem(H,[H|L],L).
member_rem(E,[H|L],[H|R]) :- member_rem(E,L,R).

% 2)

% function used to shuffle a list to get a random ordering	
shuffle(X,Y) :- random_permutation(X,Y).

% function to produce a list of N length from a list of elements
gen_list_n(0,_,[]).
gen_list_n(N,D,[L|T]) :-
	N > 0,
	% sort is used to remove duplcate items from list
	sort(D,D1),
	% randomly orders items in the list
	shuffle(D1,D2),
	% after removing duplicates a check is made to make sure N isn't smaller than the length of the input list
	length(D2,R),
	N >= R,
	N1 is N-1,
	% removes the item being added to the new list from the input list
	member_rem(L,D2,D3),
	gen_list_n(N1,D3,T).
	
% function to generate a list of 4 distinctive elements between 1-4 using gen_list_n
gen4(L) :- gen_list_n(4,[1,2,3,4],L).

% 3)

% function which checks that elements at the same index in 2 lists are not the same
distinct_in_entries([],[]).
distinct_in_entries([H1|X],[H2|Y]) :-
	H1 =\= H2,
	distinct_in_entries(X,Y).
	
% 4)

% function that generates possible solutions for our puzzle by making sure that each row and column has only 1 instance of each number between 1 and 4
gen_poss_soln([R1,R2,R3,R4]) :-
	gen4(R1),
	gen4(R2),
	distinct_in_entries(R1,R2),
	gen4(R3),
	distinct_in_entries(R1,R3),
	distinct_in_entries(R2,R3),
	gen4(R4),
	distinct_in_entries(R1,R4),
	distinct_in_entries(R2,R4),
	distinct_in_entries(R3,R4).

% 5)

% function to generate the solution to the puzzle using constraints in the puzzle.
solve([R1,R2,R3,R4]) :-
	gen_poss_soln([R1,R2,R3,R4]),
	R1 = [R11,R12,_,_],
	R11 > R12,
	R2 = [R21,R23,_,R24],
	R21 < R23,
	R3 = [R31,R32,R33,R34],
	R24 > R34,
	R31 > R32, R33 < R34, 
	R4 = [_,_,R43,R44],
	R43 < R44.
	
% 6)

% more efficient function that only generates solutions if they match the constraints rather than generating all possible solutions first.
solve_in_steps([R1,R2,R3,R4]) :-
	gen4(R1),
	R1 = [R11,R12,_,_],
	R11 > R12,
	gen4(R2),
	distinct_in_entries(R1,R2),
	R2 = [R21,R23,_,R24],
	R21 < R23,
	gen4(R3),
	distinct_in_entries(R1,R3),
	distinct_in_entries(R2,R3),
	R3 = [R31,R32,R33,R34],
	R24 > R34,
	R31 > R32, R33 < R34, 
	gen4(R4),
	distinct_in_entries(R1,R4),
	distinct_in_entries(R2,R4),
	distinct_in_entries(R3,R4),
	R4 = [_,_,R43,R44],
	R43 < R44.
	

% LISTS 1-5 EFFICIENCY CHECK BELOW:

/*
gen5(L) :- gen_list_n(5,[1,2,3,4,5],L).

gen_poss_soln([R1,R2,R3,R4,R5]) :-
	gen5(R1),
	gen5(R2),
	distinct_in_entries(R1,R2),
	gen5(R3),
	distinct_in_entries(R1,R3),
	distinct_in_entries(R2,R3),
	gen5(R4),
	distinct_in_entries(R1,R4),
	distinct_in_entries(R2,R4),
	distinct_in_entries(R3,R4),
	gen5(R5),
	distinct_in_entries(R1,R5),
	distinct_in_entries(R2,R5),
	distinct_in_entries(R3,R5),
	distinct_in_entries(R4,R5).

solve([R1,R2,R3,R4,R5]) :-
	gen_poss_soln([R1,R2,R3,R4,R5]),
	R1 = [R11,R12,_,_,_],
	R11 > R12,
	R2 = [R21,R23,_,R24,_],
	R21 < R23,
	R3 = [R31,R32,R33,R34,_],
	R24 > R34,
	R31 > R32, R33 < R34, 
	R4 = [_,_,R43,R44,_],
	R43 < R44.

solve_in_steps([R1,R2,R3,R4,R5]) :-
	gen5(R1),
	R1 = [R11,R12,_,_,_],
	R11 > R12,
	gen5(R2),
	distinct_in_entries(R1,R2),
	R2 = [R21,R23,_,R24,_],
	R21 < R23,
	gen5(R3),
	distinct_in_entries(R1,R3),
	distinct_in_entries(R2,R3),
	R3 = [R31,R32,R33,R34,_],
	R24 > R34,
	R31 > R32, R33 < R34, 
	gen5(R4),
	distinct_in_entries(R1,R4),
	distinct_in_entries(R2,R4),
	distinct_in_entries(R3,R4),
	R4 = [_,_,R43,R44,_],
	R43 < R44,
	gen5(R5),
	distinct_in_entries(R1,R5),
	distinct_in_entries(R2,R5),
	distinct_in_entries(R3,R5),
	distinct_in_entries(R4,R5).
	
	
test :-
	time(solve([R1,R2,R3,R4,R5])),
	time(solve_in_steps([R1,R2,R3,R4,R5])).
	
USING TEST, PROLOG OUTPUTS THE RUNTIME FOR EACH FUNCTION OF solve & solve_in_steps WITH 1-5 , RESULTS BELOW:

?- test.
% 2,697,760 inferences, 0.125 CPU in 0.126 seconds (99% CPU, 21582080 Lips)
% 367 inferences, 0.000 CPU in 0.000 seconds (?% CPU, Infinite Lips)
true .

*/



	






