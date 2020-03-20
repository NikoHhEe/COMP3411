% Zhichao He  z5282955 Assignment1-Prolog and Search

% Q1.1
% sumsq_even(Numbers, Sum)
% Numbers: a list of integers 
% Sum: the sum of all the squares of the even numbers in the list

% Base case: empty list
% Return 0 as there is no number in the list
sumsq_even([], 0).
% otherwise
% If head of list is even, recurively call with the tail 
% and add the square of head to the Sum
sumsq_even([Head|Tail], Sum) :-
    0 is Head mod 2,
    sumsq_even(Tail, SumTail),
    Sum is SumTail + Head * Head.
% If head of list is odd, recursively call with the tail
% without changing the Sum
sumsq_even([Head|Tail], Sum) :-
    1 is Head mod 2,
    sumsq_even(Tail, Sum).



% Q1.2
% log_table(NumberList,ResultList) 
% NumberList: a list of numbers
% ResultList: a list of pairs consisting of a number and its log, 
%             for each number in NumberList. 

% Base case: empty list
log_table([], []).
% otherwise
% Calculate the log of head and make a pair of head and its log
% [Head,Log], add the pair to the start of the ResultList
% then recursively call with the tail of NumberList
log_table([Head|Tail], [[Head,Log]|ResultTail]) :-
    Head > 0,
    Log is log(Head),
    log_table(Tail, ResultTail).



% Q1.3
% paruns(List,RunList)
% List: a list of integers
% RunList: a list of list of integers where each list is a maximal
%         sequence of consecutive even or odd numbers within the
%         original list

% base case: empty list, just return empty list
paruns([],[]).
paruns([Head|Tail], RunList) :-
    odd_even([Head|Tail], OddList, EvenList),
    merge(OddList, EvenList, Head, RunList).

% odd_even(List, OddList, EvenList)
% divide the list into a list of odd lists and a list of even lists
% e.g. odd_even([8,0,4,3,7,2,-1,9,9], [[3,7],[-1,9,9]], [[8,0,4],[2]])
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

% merge(OddList, EvenList, Head, RunList)
% merge the odd lists and even lists 
% e.g. merge([[3,7],[-1,9,9]], [[8,0,4],[2]], 8, [[8, 0, 4], [3, 7], [2], [-1, 9, 9]])
merge(List, [], _,List).
merge([], List, _,List).
merge([H1|T1], [H2|T2], Head, [H1,H2|RunList]) :-
    odd(Head),      % if head of list is odd, merge the OddList first
    merge(T1, T2, Head, RunList).
merge([H1|T1], [H2|T2], Head, [H2,H1|RunList]) :-
    even(Head),     % if head of list is even, merge the EvenList first
    merge(T1, T2, Head, RunList).

% helper predicate to indicate parity
odd(Num) :- integer(Num), 1 is Num mod 2.
even(Num) :- integer(Num), 0 is Num mod 2.



% Q1.4
% eval(Expr, Val)
% Expr: an arithmetic expression written in prefix format
% Val: the final value of the expression

% Base case 1: an atomic number 
eval(Num, Num) :- number(Num).
% Base case 2: operation on two atomic numbers
% addition
eval(add(Num1, Num2), Result) :- 
    number(Num1), number(Num2), 
    Result is Num1 + Num2.
% subtraction
eval(sub(Num1, Num2), Result) :- 
    number(Num1), number(Num2),
    Result is Num1 - Num2.
% multiplication
eval(mul(Num1, Num2), Result) :- 
    number(Num1), number(Num2),
    Result is Num1 * Num2.
% division
eval(div(Num1, Num2), Result) :- 
    number(Num1), number(Num2),
    Result is Num1 / Num2.

% expressions contains other expressions (not atomic)
% addition
eval(add(Expr1, Expr2), Result) :-
    evalEE(Expr1, Expr2, Result1, Result2),
    eval(add(Result1, Result2), Result).
% subtraction
eval(sub(Expr1, Expr2), Result) :-
    evalEE(Expr1, Expr2, Result1, Result2),
    eval(sub(Result1, Result2), Result).
% multiplication
eval(mul(Expr1, Expr2), Result) :-
    evalEE(Expr1, Expr2, Result1, Result2),
    eval(mul(Result1, Result2), Result).
% division
eval(div(Expr1, Expr2), Result) :-
    evalEE(Expr1, Expr2, Result1, Result2),
    eval(div(Result1, Result2), Result).

% helper predicate to simplify the code 
evalEE(Expr1, Expr2, Result1, Result2) :-
    eval(Expr1, Result1),
    eval(Expr2, Result2).