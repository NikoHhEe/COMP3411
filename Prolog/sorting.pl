conc([], X, X).
conc([A | B], C, [A | D]) :- 
	conc(B, C, D).
	
rev([], []).
rev([A | B], C) :- 
	rev(B, D),
	conc(D, [A], C).
	
insert(Num, [], [Num]).
insert(Num, [Head | Tail], [Num,Head | Tail]) :- Num < Head.
insert(Num, [Head | Tail1], [Head | Tail2]) :- insert(Num, Tail1, Tail2).

isort([], []).
isort([Head | Tail], SortList) :- 
	isort(Tail, SortTemp),
	insert(Head, SortTemp, SortList).
	      
/* split([], [], []).
split([Head | Tail], List1, _) :- Tail == [],
	split(Tail, List1Temp, _),
	insert(Head, List1Temp, List1).
split([Fst,Snd | Tail], List1, List2) :-
	split(Tail, List1Temp, List2Temp),
	insert(Fst, List1Temp, List1),
	insert(Snd, List2Temp, List2).
 */
split([], [], []).
split([Num], [Num], []).
split([Head1,Head2|Tail], [Head1|Tail1], [Head2|Tail2]) :-
    split(Tail, Tail1, Tail2).

/* merge(Sort1, [], Sort1).
merge([], Sort2, Sort2).
merge([Head1 | Tail1], [Head2 | Tail2], SortList) :-
	Head1 < Head2,
	merge(Tail1, [Head2 | Tail2], SortTemp),
	insert(Head1, SortTemp, SortList).
merge([Head1 | Tail1], [Head2 | Tail2], SortList) :-
	merge([Head1 | Tail1], Tail2, SortTemp),
	insert(Head2, SortTemp, SortList).	 
*/
merge(List, [], List).
merge([], List, List).
merge([Head1|Tail1], [Head2|Tail2], [Head1|Tail3]) :-
    Head1 < Head2,
    merge(Tail1, [Head2|Tail2], Tail3).
merge([Head1|Tail1], [Head2|Tail2], [Head2|Tail3]) :-
    Head1 >= Head2,
    merge([Head1|Tail1], Tail2, Tail3).


%mergesort([], []).
mergesort([Num], [Num]).
mergesort(List, NewList) :-
	split(List, List1, List2),
	mergesort(List1, List1Sort),
	mergesort(List2, List2Sort),
	merge(List1Sort, List2Sort, NewList).
