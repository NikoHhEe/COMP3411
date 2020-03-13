% Zhichao He  z5282955 Assignment1-Prolog and Search

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



% paruns(List,RunList)
% List: a list of integers
% RunList: a list of list of integers where each list is a maximal
%         sequence of consecutive even or odd numbers within the
%         original list

% Base case 1: empty list
paruns([], []).
% base case 2: list with only one number
paruns([Num], [[Num]]).
% otherwise
% if head of List and head of head list in RunList have the
% same parity, insert the head to the start of the head list 
% in RunList (using headInsert)
paruns([Head|Tail], [[SubHead|SubTail]|RunTail]) :- 
    paruns(Tail, [[SubHead1|SubTail1]|RunTail]),
    same(Head, SubHead1),
    headInsert(Head, [SubHead1|SubTail1], [SubHead|SubTail]).

% if head of List and head of head list in RunList have
% different parity, create a new list containing only 
% head of List, and insert the [Head] list to the start
% of the RunList (using headInsert)
paruns([Head|Tail], [[SubHead|SubTail]|RunTail]) :-
    paruns(Tail, [[SubHead1|SubTail1]|RunTail1]),
    \+ same(Head, SubHead1),
    headInsert([Head], [[SubHead1|SubTail1]|RunTail1], [[SubHead|SubTail]|RunTail]).

% helper predicates to determine the parity
odd(Num) :- integer(Num), 1 is Num mod 2.
even(Num) :- integer(Num), 0 is Num mod 2.
same(Num1, Num2) :- odd(Num1), odd(Num2).
same(Num1, Num2) :- even(Num1), even(Num2).

% helper predicates to insert a node to the start of a list
headInsert(NewHead, [], [NewHead]).
headInsert(NewHead, [Head|Tail], [NewHead, Head|Tail]).



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
% eval(Expr, Result) :-
%     Expr =.. [Op,Arg1,Arg2|_],
%     eval(Expr1, Expr2, Result1, Result2),
%     eval(Op(Result1, Result2), Result).

% addition
eval(add(Expr1, Expr2), Result) :-
    eval(Expr1, Expr2, Result1, Result2),
    eval(add(Result1, Result2), Result).
% subtraction
eval(sub(Expr1, Expr2), Result) :-
    eval(Expr1, Expr2, Result1, Result2),
    eval(sub(Result1, Result2), Result).
% multiplication
eval(mul(Expr1, Expr2), Result) :-
    eval(Expr1, Expr2, Result1, Result2),
    eval(mul(Result1, Result2), Result).
% division
eval(div(Expr1, Expr2), Result) :-
    eval(Expr1, Expr2, Result1, Result2),
    eval(div(Result1, Result2), Result).

% helper predicate to simplify the code 
eval(Expr1, Expr2, Result1, Result2) :-
    eval(Expr1, Result1),
    eval(Expr2, Result2).