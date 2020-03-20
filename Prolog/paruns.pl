paruns([],[]).
paruns([Head|Tail], RunList) :-
    odd_even([Head|Tail], OddList, EvenList),
    merge(OddList, EvenList, Head, RunList).

odd_even([Head], [[Head]], []) :- odd(Head).
odd_even([Head], [], [[Head]]) :- even(Head).
odd_even([Fst,Snd|Tail], [[Fst|OddTail1]|OddTail], EvenList) :- 
    odd(Fst), odd(Snd),
    odd_even([Snd|Tail], [OddTail1|OddTail], EvenList).

odd_even([Fst,Snd|Tail], OddList, [[Fst|EvenTail1]|EvenTail]) :- 
    even(Fst), even(Snd),
    odd_even([Snd|Tail], OddList, [EvenTail1|EvenTail]).

odd_even([Fst,Snd|Tail], OddList, [[Fst]|EvenTail]) :- 
    even(Fst), odd(Snd),
    odd_even([Snd|Tail], OddList, EvenTail).
odd_even([Fst,Snd|Tail], [[Fst]|OddTail], EvenList) :-
    odd(Fst), even(Snd),
    odd_even([Snd|Tail], OddTail, EvenList).

merge(List, [], _,List).
merge([], List, _,List).
merge([H1|T1], [H2|T2], Head, [H1,H2|RunList]) :-
    odd(Head),
    merge(T1, T2, Head, RunList).
merge([H1|T1], [H2|T2], Head, [H2,H1|RunList]) :-
    even(Head),
    merge(T1, T2, Head, RunList).

odd(Num) :- integer(Num), 1 is Num mod 2.
even(Num) :- integer(Num), 0 is Num mod 2.

% paruns([],[]).
% paruns([Head|Tail], RestTail) :-
%     evenList([Head|Tail], Even, Rest),
%     oddList(Rest, Odd, Rest1),
%     (Even=[]->RestTail=[Odd|RestTail]; Odd=[]->RestTail=[Even|RestTail]; RestTail=[Even,Odd|RestTail]),
%     paruns(Rest1, RestTail).

% evenList([],[],[]).
% evenList([Head|Tail], [], [Head|Tail]) :- odd(Head).
% evenList([Head|Tail], [Head|EvenTail], Rest) :- 
%     even(Head),
%     evenList(Tail, EvenTail, Rest).

% oddList([],[],[]).
% oddList([Head|Tail], [], [Head|Tail]) :- even(Head).
% oddList([Head|Tail], [Head|OddTail], Rest) :-
%     odd(Head),
%     oddList(Tail, OddTail, Rest).

l([], 0).
l([_|T], L) :-
    l(T, L1),
    L is 1 + L1.

l1([_|T], L) :-
    l1(T, L1),
    L is 1 + L1.
l1([], 0).